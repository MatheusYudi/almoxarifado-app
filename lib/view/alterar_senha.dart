import 'package:almoxarifado/util/routes.dart';
import 'package:flutter/material.dart';

import '../controller/funcionario_atual_controller.dart';
import '../widgets/default_text_form_field.dart';

class AlterarSenha extends StatefulWidget {
  final String token;

  const AlterarSenha({Key? key, this.token = ""}) : super(key: key);

  @override
  State<AlterarSenha> createState() => _AlterarSenhaState();
}
class _AlterarSenhaState extends State<AlterarSenha> {

  TextEditingController confirmarSenha = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool visibilidadeSenha = false;
  bool visibilidadeConfirmarSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: Row(
          children: [
            const Icon(Icons.lightbulb_outline),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 40,
                width: 1,
                color: Colors.white,
              ),
            ),
            const Flexible(
              fit: FlexFit.tight,
              child: Text("Alterar Senha"),
            ),
          ],
        ),
        // actions: actions,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(
                width: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: senha,
                        labelText: 'Senha',
                        keyboardType: TextInputType.number,
                        obscureText: !visibilidadeSenha,
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => visibilidadeSenha = !visibilidadeSenha,
                          ),
                          child: Icon(
                            visibilidadeSenha
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF757575),
                          ),
                        ),
                        validator: (value)
                        {
                          if (value == null || value.isEmpty) {
                            return 'Digite algum valor';
                          }
                          else if(value.length < 6)
                          {
                            return 'A Senha deve ter no minimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: confirmarSenha,
                        labelText: 'Confirmar Senha',
                        keyboardType: TextInputType.number,
                        obscureText: !visibilidadeConfirmarSenha,
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => visibilidadeConfirmarSenha = !visibilidadeConfirmarSenha,
                          ),
                          child: Icon(
                            visibilidadeConfirmarSenha
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF757575),
                          ),
                        ),
                        validator: (value)
                        {
                          if (value == null || value.isEmpty) {
                            return 'Digite algum valor';
                          }
                          else if(value.length < 6)
                          {
                            return 'A Senha deve ter no minimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Alterar Senha'),
                        style: ButtonStyle(
                          maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                          minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
                        ),
                        onPressed: () async {
                          FuncionarioAtualController request = FuncionarioAtualController();

                          await request.alterarSenha(context, senha.text, widget.token);

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
                            Navigator.pushReplacementNamed(context, Routes.login);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}