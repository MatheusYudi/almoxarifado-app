import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

import '../../controller/funcionarios_controller.dart';
import '../../controller/requisicoes_controller.dart';
import '../../model/funcionario.dart';
import '../../model/requisicao.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class Requisicoes extends StatefulWidget {
  const Requisicoes({ Key? key }) : super(key: key);

  @override
  State<Requisicoes> createState() => _RequisicoesState();
}

class _RequisicoesState extends State<Requisicoes> {

  TextEditingController dataInicio = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  TextEditingController requisitante = TextEditingController();
  TextEditingController status = TextEditingController();

  bool requisicoesLoading = false;
  List<Requisicao> requisicoes = [];
  List<Requisicao> requisicoesGrid = [];

  bool funcionariosLoading = false;
  List<Funcionario> funcionarios = [];
  Funcionario? funcionarioSelecionado;

  fetchRequisicoes() async
  {
    setState(() => requisicoesLoading = true);
    requisicoes = await RequisicoesController().getRequisicoes(context);
    requisicoesGrid = requisicoes;
    setState(() => requisicoesLoading = false);
  }

  fetchFuncionarios() async
  {
    setState(() => funcionariosLoading = true);
    funcionarios = await FuncionariosController().getFuncionarios(context);
    setState(() => funcionariosLoading = false);
  }

  @override
  void initState() {
    fetchRequisicoes();
    fetchFuncionarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Requisições'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const Text('Período', style: TextStyle(color: Colors.white),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    child: DefaultTextFormField(
                                      controller: dataInicio,
                                      keyboardType: TextInputType.datetime,
                                      inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
                                      labelText: 'De',
                                      suffixIcon: IconButton(
                                        padding: const EdgeInsets.all(8.0),
                                        onPressed: (){
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          ).then((value){
                                            if(value != null)
                                            {
                                              setState(() => dataInicio.text = DateFormat("dd/MM/yyyy").format(value));
                                            }
                                          });
                                        },
                                        icon: const Icon(Icons.date_range_rounded, size: 20),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: DefaultTextFormField(
                                      controller: dataFim,
                                      keyboardType: TextInputType.datetime,
                                      inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
                                      labelText: 'Até',
                                      suffixIcon: IconButton(
                                        padding: const EdgeInsets.all(8.0),
                                        onPressed: (){
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          ).then((value){
                                            if(value != null)
                                            {
                                              setState(() => dataFim.text = DateFormat("dd/MM/yyyy").format(value));
                                            }
                                          });
                                        },
                                        icon: const Icon(Icons.date_range_rounded, size: 20),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultDropDown(
                                  controller: requisitante,
                                  labelText: 'Requisitante',
                                  itens: funcionarios.map((funcionario){
                                    return DropdownMenuItem(
                                      value: funcionario.nome,
                                      child: Text(funcionario.nome),
                                      onTap: () => funcionarioSelecionado = funcionario,
                                    );
                                  }).toList(),
                                ),
                              ),
                              Flexible(
                                child: DefaultDropDown(
                                  controller: status,
                                  labelText: 'Status',
                                  itens: [],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.add_box_outlined,
                              color: Color(0xFF43a047),
                            ),
                            label: const Text(
                              'Cadastrar',
                              style: TextStyle(color: Color(0xFF43a047)),
                            ),
                            onPressed: () => Navigator.pushNamed(context, Routes.requisicaoForm),
                            style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                              minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(                            
                            child: const Icon(Icons.search),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                            ),
                            onPressed: (){
                              requisicoesGrid = requisicoes.where((inventario){
                                if(inventario.requisitante == null || funcionarioSelecionado == null)
                                {
                                  return true;
                                }
                                if(inventario.requisitante!.id == funcionarioSelecionado!.id)
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
                              requisicoesGrid = requisicoesGrid.where((inventario){
                                if(dataInicio.text.isEmpty || dataFim.text.isEmpty)
                                {
                                  return true;
                                }
                                DateTime dataInicioParse = DateTime.parse("${dataInicio.text.split('/')[2]}-${dataInicio.text.split('/')[1]}-${dataInicio.text.split('/')[0]}");
                                DateTime dataFimParse = DateTime.parse("${dataFim.text.split('/')[2]}-${dataFim.text.split('/')[1]}-${dataFim.text.split('/')[0]}");
                                if(inventario.dataHora!.isAfter(dataInicioParse) && inventario.dataHora!.isBefore(dataFimParse))
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
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
                        link: 'delete',
                        displayPercentage: 10,
                        sortable: false,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'edit',
                        displayPercentage: 10,
                        sortable: false,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'avaliar',
                        displayPercentage: 10,
                        sortable: false,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'requisitante',
                        title: 'Requisitante',
                        displayPercentage: 50,
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'data',
                        title: 'Data',
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                        enableSearch: false,
                      ),
                    ],
                    data: requisicoes.map((requisicao){
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'delete',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                RequisicoesController().deleteRequisicao(context, requisicao.id!).then((value){
                                  fetchRequisicoes();
                                });
                              },
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'edit',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.blue,
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                Navigator.pushNamed(context, Routes.requisicaoForm, arguments: requisicao.id!).then((value){
                                  fetchRequisicoes();
                                });
                              },
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'avaliar',
                          ),
                          DataGridRowColumn(
                            link: 'requisitante',
                            display: Text(requisicao.requisitante!.nome),
                            textCompareOrder: requisicao.requisitante!.nome,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'data',
                            display: Text(DateFormat('dd/MM/yyyy').format(requisicao.dataHora!)),
                            textCompareOrder: DateFormat('dd/MM/yyyy').format(requisicao.dataHora!),
                            alignment: Alignment.centerLeft,
                          ),
                        ]
                      );
                    }).toList(),
                    width: MediaQuery.of(context).size.width - 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const DefaultUserDrawer(),
    );
  }
}