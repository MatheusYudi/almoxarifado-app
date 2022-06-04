import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  TextEditingController data = TextEditingController();
  TextEditingController operador = TextEditingController();

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