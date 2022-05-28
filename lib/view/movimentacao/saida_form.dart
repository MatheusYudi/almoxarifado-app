import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/routes.dart';
import '../../widgets/default_text_form_field.dart';

class SaidaForm extends StatefulWidget {
  const SaidaForm({ Key? key }) : super(key: key);

  @override
  State<SaidaForm> createState() => _SaidaFormState();
}

class _SaidaFormState extends State<SaidaForm> {

  TextEditingController codigo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController quantidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 600,
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
                        Text('Saída'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 600,
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
                          ],
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