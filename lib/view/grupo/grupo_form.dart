import 'package:flutter/material.dart';

import '../../widgets/default_text_form_field.dart';

class GrupoForm extends StatefulWidget {
  const GrupoForm({ Key? key }) : super(key: key);

  @override
  State<GrupoForm> createState() => _GrupoFormState();
}

class _GrupoFormState extends State<GrupoForm> {

  TextEditingController grupo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(16),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: DefaultTextFormField(
                      controller: grupo,
                      labelText: 'Nome',
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}