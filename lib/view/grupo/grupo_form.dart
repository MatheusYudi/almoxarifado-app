import 'package:flutter/material.dart';

import '../../widgets/default_app_bar.dart';
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
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Theme.of(context).primaryColor,
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: const [
                        Text('Grupo'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(16),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}