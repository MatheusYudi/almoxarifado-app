import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

import '../widgets/data_grid.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_dropdown.dart';
import '../widgets/default_text_form_field.dart';

class Inventarios extends StatefulWidget {
  const Inventarios({ Key? key }) : super(key: key);

  @override
  State<Inventarios> createState() => _InventariosState();
}

class _InventariosState extends State<Inventarios> {

  TextEditingController dataInicio = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  TextEditingController operador = TextEditingController();

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
                                              setState(() => dataFim.text = DateFormat("dd/MM/yyyy").format(value));
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
                          child: ElevatedButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children:  [
                                Container(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: const Icon(
                                    Icons.add_box_outlined,
                                    color: Color(0xFF43a047),
                                  ),
                                ),
                                const Flexible(
                                  fit: FlexFit.tight,
                                  child: Text(
                                    'Cadastrar',
                                    style: TextStyle(color: Color(0xFF43a047)),
                                  ),
                                ),
                              ],
                            ),
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
                            onPressed: (){},
                            child: const Icon(Icons.search),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                            ),
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
                    headers: const [],
                    data: const [],//TesteData.clientes,
                    width: MediaQuery.of(context).size.width - 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: const DefaultUserDrawer(),
    );
  }
}