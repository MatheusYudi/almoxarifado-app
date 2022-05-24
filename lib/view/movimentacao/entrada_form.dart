import 'package:flutter/material.dart';

import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class EntradaForm extends StatefulWidget {
  const EntradaForm({ Key? key }) : super(key: key);

  @override
  State<EntradaForm> createState() => _EntradaFormState();
}

class _EntradaFormState extends State<EntradaForm> {

  TextEditingController numeroNota = TextEditingController();
  TextEditingController chave = TextEditingController();
  TextEditingController fornecedor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Entrada'),
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
                                  controller: numeroNota,
                                  labelText: 'Número da Nota',
                                 ),
                              ),
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: chave,
                                  labelText: 'Chave',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: DefaultDropDown(
                                  controller: fornecedor,
                                  labelText: 'Fornecedor',
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
                Flexible(
                  child: DataGrid(
                    headers: [],
                    data: [],
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