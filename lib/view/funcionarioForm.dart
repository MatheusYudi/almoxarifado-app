import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../widgets/default_app_bar.dart';
import '../widgets/default_dropdown.dart';
import '../widgets/default_text_form_field.dart';

class FuncionarioForm extends StatefulWidget {
  const FuncionarioForm({ Key? key }) : super(key: key);

  @override
  State<FuncionarioForm> createState() => _FuncionarioFormState();
}

class _FuncionarioFormState extends State<FuncionarioForm> {

  TextEditingController cpf = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();
  TextEditingController grupoAcesso = TextEditingController();
  bool visibilidadeConfirmarSenha = false;
  bool visibilidadeSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Funcionarios'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: cpf,
                        labelText: 'Cpf',
                        inputFormatters: [MaskTextInputFormatter(mask: "###.###.###-##")],
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: nome,
                        labelText: 'Nome',
                      ),
                    ),                    
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultDropDown(
                        controller: grupoAcesso,
                        labelText: 'Grupo de Acesso',
                        itens: [],
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: email,
                        labelText: 'Email',
                        keyboardType: TextInputType.number,
                      ),
                    ),                    
                  ],
                ),
                Row(
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
                      ),
                    ),
                  ],
                )
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