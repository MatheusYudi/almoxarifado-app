import 'package:flutter/material.dart';

import '../controller/funcionario_atual_controller.dart';
import '../widgets/default_text_form_field.dart';

class RecuperarSenhaForm extends StatefulWidget {
  const RecuperarSenhaForm({ Key? key }) : super(key: key);

  @override
  State<RecuperarSenhaForm> createState() => _RecuperarSenhaFormState();
}
//TODO testar rotina de recuperar senha
class _RecuperarSenhaFormState extends State<RecuperarSenhaForm> {
  
  TextEditingController email = TextEditingController();
  
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
                        Text('Recuperar Senha'),
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
                        const Flexible(
                          child: Text(
                            'Ao clicar em "Enviar Email" será enviado ao email digitado um link para a recuperação da senha',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),                 
                        Flexible(
                          child: DefaultTextFormField(
                            controller: email,
                            labelText: 'Email',
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
                                    icon: const Icon(Icons.outgoing_mail),
                                    label: const Text('Enviar Email'),
                                    style: ButtonStyle(
                                      maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                                      minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                                      backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
                                    ),
                                    onPressed: () async {
                                      FuncionarioAtualController request = FuncionarioAtualController();
                                      
                                      await request.recuperarSenha(context, email.text);
                                      
                                      if (request.error != '') {
                                        showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              title: const Text('Algo deu errado'),
                                              content: Text(request.error),
                                            );
                                          },
                                        );
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.cancel),
                                    label: const Text('Cancelar'),
                                    style: ButtonStyle(
                                      maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                                      minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                                      backgroundColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                    onPressed: () => Navigator.pop(context),
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