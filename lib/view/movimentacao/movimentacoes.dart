import 'package:almoxarifado/view/movimentacao/saida_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';
import '../../widgets/default_user_drawer.dart';

class Movimentacoes extends StatefulWidget {
  const Movimentacoes({ Key? key }) : super(key: key);

  @override
  State<Movimentacoes> createState() => _MovimentacoesState();
}

class _MovimentacoesState extends State<Movimentacoes> {

  TextEditingController dataInicio = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  TextEditingController codigo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController grupo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Movimentações'),
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
                          Row(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: codigo,
                                  labelText: 'Código',
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: DefaultTextFormField(
                                  controller: descricao,
                                  labelText: 'Descrição',
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: DefaultDropDown(
                                  controller: grupo,
                                  labelText: 'Grupo',
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
                              Icons.outbond_outlined,
                              color: Colors.blue,
                            ),
                            label: const Text(
                              'Saída',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const SaidaForm(),
                              );
                            },
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
      drawer: const DefaultUserDrawer(),
    );
  }
}