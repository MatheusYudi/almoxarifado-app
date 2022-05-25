import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  TextEditingController operador = TextEditingController(text: 'Operador');
  TextEditingController codigo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController quantidade = TextEditingController();
  bool editando = false;

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
                                  itens: [],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: codigo,
                                  labelText: 'Código',
                                  enabled: false,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\,?\d{0,2}'))],
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: DefaultTextFormField(
                                  controller: descricao,
                                  labelText: 'Descrição',
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
                                        showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              content: Text(value.toString()),
                                            );
                                          }
                                        );
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
                                  onPressed: () => editando = false,
                                  child: editando
                                    ? const Icon(Icons.add_box_outlined)
                                    : const Icon(Icons.edit),
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                                  ),
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
                            link: 'edit',
                            alignment: Alignment.center,
                            sortable: false,
                            enableSearch: false,
                            displayPercentage: 10,
                          ),
                          DataGridHeader(
                            link: 'descricao',
                            title: 'Descrição',
                            alignment: Alignment.centerLeft,
                            displayPercentage: 20,
                          ),
                          DataGridHeader(
                            link: 'qtdSistema',
                            title: 'Quantidade de Sistema',
                            alignment: Alignment.centerLeft,
                            displayPercentage: 35,
                          ),
                          DataGridHeader(
                            link: 'qtdFisico',
                            title: 'Quantidade Fisica',
                            alignment: Alignment.centerLeft,
                            displayPercentage: 35,
                          ),
                        ],
                        data: [
                          DataGridRow(
                            onDoubleTap: () => Navigator.pop(context, 'Produto 1'),
                            columns: [
                              DataGridRowColumn(
                                link: 'edit',
                                alignment: Alignment.center,
                                display: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => editando = true,
                                ),
                              ),
                              DataGridRowColumn(
                                link: 'descricao',
                                display: const Text('Produto 1'),
                                alignment: Alignment.centerLeft,
                              ),
                              DataGridRowColumn(
                                link: 'qtdSistema',
                                display: const Text('5'),
                                alignment: Alignment.centerLeft,
                              ),
                              DataGridRowColumn(
                                link: 'qtdFisico',
                                display: const Text('10'),
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          ),
                        ],
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
              onPressed: () {},
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
              ),
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