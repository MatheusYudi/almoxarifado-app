import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../controller/requisicoes_controller.dart';
import '../../model/funcionario.dart';
import '../../model/requisicao.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class AvaliarRequisicao extends StatefulWidget {

  const AvaliarRequisicao({ Key? key }) : super(key: key);

  @override
  State<AvaliarRequisicao> createState() => _AvaliarRequisicaoState();
}

class _AvaliarRequisicaoState extends State<AvaliarRequisicao> {

  TextEditingController data = TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  TextEditingController operador = TextEditingController(text: 'Administrador');
  
  bool preenchido = false;
  dynamic argument;

  Requisicao requisicao = Requisicao();
  Funcionario? funcionarioSelecionado;

  fetchRequisicao() async {
    requisicao = await RequisicoesController().getRequisicaoById(context, argument);
    operador.text = requisicao.requisitante!.nome;
    funcionarioSelecionado = requisicao.requisitante;
    data.text = DateFormat("dd/MM/yyyy").format(requisicao.dataHora!);
    setState((){});
  }

  @override
  void initState() {
    fetchRequisicao();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!preenchido)
    {
      argument = ModalRoute.of(context)!.settings.arguments;
      if(argument.runtimeType == int)
      {
        fetchRequisicao();
      }
      preenchido = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Avaliar Requisição'),
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
                                  itens: [],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'codigoBarras',
                        title: 'Código de Barras',
                        displayPercentage: 25,
                        sortable: false,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'nome',
                        title: 'Nome',
                        displayPercentage: 50,
                        sortable: false,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'qtd',
                        title: 'Quantidade',
                        displayPercentage: 25,
                        sortable: false,
                        enableSearch: false,
                      ),
                    ],
                    data: requisicao.itens!.map((item){
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'codigoBarras',
                            display: Text(item.material!.codigoBarras),
                            textCompareOrder: item.material!.codigoBarras,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'nome',
                            display: Text(item.material!.nome),
                            textCompareOrder: item.material!.nome,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'qtd',
                            display: Text(item.qtd.toString()),
                            textCompareOrder: item.qtd.toString(),
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
              label: const Text('Aprovar'),
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
              ),
              onPressed: () async {
                RequisicoesController request = RequisicoesController();
                
                await request.finalizarRequisicao(context, requisicao.id!);

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
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}