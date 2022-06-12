import 'package:almoxarifado/controller/funcionarios_controller.dart';
import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

import '../../controller/inventarios_controller.dart';
import '../../model/funcionario.dart';
import '../../model/inventario.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class Inventarios extends StatefulWidget {
  const Inventarios({ Key? key }) : super(key: key);

  @override
  State<Inventarios> createState() => _InventariosState();
}

class _InventariosState extends State<Inventarios> {

  TextEditingController dataInicio = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  TextEditingController operador = TextEditingController();

  bool inventariosLoading = false;
  List<Inventario> inventarios = [];
  List<Inventario> inventariosGrid = [];

  bool funcionariosLoading = false;
  List<Funcionario> funcionarios = [];
  Funcionario? funcionarioSelecionado;

  fetchInventarios() async
  {
    setState(() => inventariosLoading = true);
    inventarios = await InventariosController().getInventarios(context);
    inventariosGrid = inventarios;
    setState(() => inventariosLoading = false);
  }

  fetchFuncionarios() async
  {
    setState(() => funcionariosLoading = true);
    funcionarios = await FuncionariosController().getFuncionarios(context);
    setState(() => funcionariosLoading = false);
  }

  @override
  void initState() {
    fetchInventarios();
    fetchFuncionarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Inventários'),
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
                                  controller: operador,
                                  labelText: 'Operador',
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
                            style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                              minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                            ),
                            onPressed: () => Navigator.pushNamed(context, Routes.inventarioForm).then((value) => fetchInventarios()),
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
                              inventariosGrid = inventarios.where((inventario){
                                if(inventario.operador == null || funcionarioSelecionado == null)
                                {
                                  return true;
                                }
                                if(inventario.operador!.id == funcionarioSelecionado!.id)
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
                              inventariosGrid = inventariosGrid.where((inventario){
                                if(dataInicio.text.isEmpty || dataFim.text.isEmpty)
                                {
                                  return true;
                                }
                                DateTime dataInicioParse = DateTime.parse("${dataInicio.text.split('/')[2]}-${dataInicio.text.split('/')[1]}-${dataInicio.text.split('/')[0]} 00:00:00");
                                DateTime dataFimParse = DateTime.parse("${dataFim.text.split('/')[2]}-${dataFim.text.split('/')[1]}-${dataFim.text.split('/')[0]} 23:59:59");

                                if(inventario.dataHora!.isAfter(dataInicioParse) && inventario.dataHora!.isBefore(dataFimParse))
                                {
                                  return true;
                                }
                                if(inventario.dataHora!.isAtSameMomentAs(dataInicioParse) || inventario.dataHora!.isAtSameMomentAs(dataFimParse))
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
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'edit',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'complete',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'operador',
                        title: 'Operador',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 30,
                      ),
                      DataGridHeader(
                        link: 'data',
                        title: 'Data',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'finalizado',
                        title: 'Finalizado?',
                        alignment: Alignment.center,
                        enableSearch: false,
                        displayPercentage: 20,
                      ),
                    ],
                    data: inventariosGrid.map((inventario){
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'delete',
                            alignment: Alignment.center,
                            display: inventario.status != 'Sim'
                            ? IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              tooltip: "Excluir",
                              onPressed: () async {
                                InventariosController().deleteInventario(context, inventario.id!).then((value){
                                  fetchInventarios();
                                });
                              },
                            )
                            : const SizedBox.shrink(),
                          ),
                          DataGridRowColumn(
                            link: 'edit',
                            alignment: Alignment.center,
                            display: inventario.status != 'Sim'
                            ? IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.blue,
                              icon: const Icon(Icons.edit),
                              tooltip: "Alterar",
                              onPressed: () async {
                                Navigator.pushNamed(context, Routes.inventarioForm, arguments: inventario.id!).then((value){
                                  fetchInventarios();
                                });
                              },
                            )
                            : const SizedBox.shrink(),
                          ),
                          DataGridRowColumn(
                            link: 'complete',
                            alignment: Alignment.center,
                            display: inventario.status != 'Sim'
                            ? IconButton(
                              padding: EdgeInsets.zero,
                              color: Theme.of(context).primaryColor,
                              icon: const Icon(Icons.check),
                              tooltip: "Finalizar",
                              onPressed: () async {
                                InventariosController request = InventariosController();
                
                                await request.finalizarInventario(context, inventario.id!);

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
                                  fetchInventarios();
                                }
                              },
                            )
                            : const SizedBox.shrink(),
                          ),
                          DataGridRowColumn(
                            link: 'operador',
                            display: Text(inventario.operador!.nome),
                            alignment: Alignment.centerLeft,
                            textCompareOrder: inventario.operador!.nome,
                          ),
                          DataGridRowColumn(
                            link: 'data',
                            display: Text(DateFormat('dd/MM/yyyy').format(inventario.dataHora!)),
                            textCompareOrder: DateFormat('dd/MM/yyyy').format(inventario.dataHora!),
                            alignment: Alignment.centerLeft
                          ),
                          DataGridRowColumn(
                            link: 'finalizado',
                            display: Text(inventario.status),
                            textCompareOrder: inventario.status,
                            alignment: Alignment.center
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