import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../controller/funcionario_atual_controller.dart';
import '../../controller/funcionarios_controller.dart';
import '../../controller/requisicoes_controller.dart';
import '../../model/funcionario.dart';
import '../../model/material_model.dart';
import '../../model/material_requisicao.dart';
import '../../model/requisicao.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class RequisicaoForm extends StatefulWidget {
  const RequisicaoForm({ Key? key }) : super(key: key);

  @override
  State<RequisicaoForm> createState() => _RequisicaoFormState();
}

class _RequisicaoFormState extends State<RequisicaoForm> {

  TextEditingController data = TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  TextEditingController operador = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController quantidade = TextEditingController();

  bool preenchido = false;
  dynamic argument;

  Requisicao requisicao = Requisicao();

  bool funcionariosLoading = false;
  List<Funcionario> funcionarios = [];
  Funcionario? funcionarioSelecionado;

  MaterialModel? materialSelecionado;

  fetchFuncionarios() async
  {
    setState(() => funcionariosLoading = true);
    funcionarios = await FuncionariosController().getFuncionarios(context);
    setState(() => funcionariosLoading = false);
  }

  fetchRequisicao() async {
    requisicao = await RequisicoesController().getRequisicaoById(context, argument);
    operador.text = requisicao.requisitante!.nome;
    funcionarioSelecionado = requisicao.requisitante;
    data.text = DateFormat("dd/MM/yyyy").format(requisicao.dataHora!);
    setState((){});
  }

  @override
  void initState() {
    fetchFuncionarios();
    funcionarioSelecionado = Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual();
    operador.text = funcionarioSelecionado!.nome;
    requisicao.requisitante = funcionarioSelecionado;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!preenchido)
    {
      argument = ModalRoute.of(context)!.settings.arguments;
      if(argument.runtimeType == int)
      {
        argument = ModalRoute.of(context)!.settings.arguments;
        fetchRequisicao();
      }
      preenchido = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Requisição'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: data,
                                  labelText: 'Data',
                                  enabled: false,
                                  inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
                                ),
                              ),
                              Flexible(
                                child: DefaultDropDown(
                                  controller: operador,
                                  labelText: 'Operador',
                                  enabled: false,
                                  itens: funcionarios.map((funcionario){
                                    return DropdownMenuItem(
                                      value: funcionario.nome,
                                      child: Text(funcionario.nome),
                                      onTap: () => funcionarioSelecionado = funcionario,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: DefaultTextFormField(
                                  controller: nome,
                                  labelText: 'Material',
                                  readOnly: true,
                                  suffixIcon: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.only(
                                        topRight:  Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.search, color: Colors.white),
                                      onPressed: () => Navigator.pushNamed(context, Routes.selecionarMaterial).then((value) {
                                        materialSelecionado = value as MaterialModel;
                                        if(materialSelecionado != null)
                                        {
                                          nome.text = materialSelecionado!.nome;
                                        }
                                        setState(() {});
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: quantidade,
                                  labelText: 'Quantidade',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\,?\d{0,2}'))],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  child: const Icon(Icons.add_box_outlined),
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                                  ),
                                  onPressed: (){
                                    if(materialSelecionado != null && quantidade.text.isNotEmpty)
                                    {
                                      requisicao.itens!.add(
                                        MaterialRequisicao(
                                          qtd: double.parse(quantidade.text),
                                          material: materialSelecionado
                                        )
                                      );
                                      materialSelecionado = null;
                                      nome.text = '';
                                      quantidade.text = '';
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'delete',
                        alignment: Alignment.center,
                        sortable: false,
                        enableSearch: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'nome',
                        title: 'Nome',
                        sortable: false,
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 70,
                      ),
                      DataGridHeader(
                        link: 'qtd',
                        title: 'Quantidade',
                        sortable: false,
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                      ),
                    ],
                    data: requisicao.itens!.map((item) {
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'delete',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                requisicao.itens!.removeWhere((itemRequisicao) => itemRequisicao.material!.id == item.material!.id);
                                setState(() {});
                              },
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'nome',
                            display: Text(item.material!.nome),
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'qtd',
                            display: Text(item.qtd.toString()),
                            alignment: Alignment.centerLeft,
                          ),
                        ]
                      );
                    }).toList(),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
              ),
              onPressed: () async {
                RequisicoesController request = RequisicoesController();
                
                await request.postRequisicao(context, requisicao);

                if(request.error != '')
                {
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Algo deu errado'),
                        content: Text(request.error),
                      );
                    },
                  );
                }
                else
                {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.cancel),
              label: const Text('Cancelar'),
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}