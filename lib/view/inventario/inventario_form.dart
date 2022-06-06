import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../controller/funcionario_atual_controller.dart';
import '../../controller/funcionarios_controller.dart';
import '../../controller/inventarios_controller.dart';
import '../../model/funcionario.dart';
import '../../model/inventario.dart';
import '../../model/material_inventario.dart';
import '../../model/material_model.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class InventarioForm extends StatefulWidget {
  const InventarioForm({ Key? key }) : super(key: key);

  @override
  State<InventarioForm> createState() => _InventarioFormState();
}

class _InventarioFormState extends State<InventarioForm> {

  TextEditingController data = TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  TextEditingController operador = TextEditingController();
  TextEditingController codigo = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController quantidade = TextEditingController();

  bool preenchido = false;
  dynamic argument;

  Inventario inventario = Inventario();

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

  fetchInventario() async {
    inventario = await InventariosController().getInventarioById(context, argument);
    operador.text = inventario.operador!.nome;
    funcionarioSelecionado = inventario.operador;
    data.text = DateFormat("dd/MM/yyyy").format(inventario.dataHora!);
    setState((){});
  }

  @override
  void initState() {
    fetchFuncionarios();
    funcionarioSelecionado = Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual();
    operador.text = funcionarioSelecionado!.nome;
    inventario.operador = funcionarioSelecionado;
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
        fetchInventario();
      }
      preenchido = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Inventário'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
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
                                  labelText: 'Nome',
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
                                      inventario.itens!.add(
                                        MaterialInventario(
                                          qtdeFisica: double.parse(quantidade.text),
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
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                            link: 'descricao',
                            title: 'Descrição',
                            sortable: false,
                            enableSearch: false,
                            alignment: Alignment.centerLeft,
                            displayPercentage: 50,
                          ),
                          DataGridHeader(
                            link: 'qtdSistema',
                            title: 'Quantidade de Sistema',
                            sortable: false,
                            enableSearch: false,
                            alignment: Alignment.centerLeft,
                            displayPercentage: 20,
                          ),
                          DataGridHeader(
                            link: 'qtdFisico',
                            title: 'Quantidade Fisica',
                            sortable: false,
                            enableSearch: false,
                            alignment: Alignment.centerLeft,
                            displayPercentage: 20,
                          ),
                        ],
                        data: inventario.itens!.map((item){
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
                                    inventario.itens!.removeWhere((itemInventario) => itemInventario.material!.id == item.material!.id);
                                    setState(() {});
                                  },
                                ),
                              ),
                              DataGridRowColumn(
                                link: 'descricao',
                                display: Text(item.material!.nome),
                                alignment: Alignment.centerLeft,
                              ),
                              DataGridRowColumn(
                                link: 'qtdSistema',
                                display: Text(item.material!.qtdeEstoque.toString()),
                                alignment: Alignment.centerLeft,
                              ),
                              DataGridRowColumn(
                                link: 'qtdFisico',
                                display: Text(item.qtdeFisica.toString()),
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          );
                        }).toList(),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
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
                InventariosController request = InventariosController();
                
                await request.postInventario(context, inventario);

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