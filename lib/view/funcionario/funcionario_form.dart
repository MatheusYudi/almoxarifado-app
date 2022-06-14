import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../controller/funcionarios_controller.dart';
import '../../controller/grupos_acesso_controller.dart';
import '../../model/funcionario.dart';
import '../../model/grupo_acesso.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class FuncionarioForm extends StatefulWidget {
  const FuncionarioForm({ Key? key }) : super(key: key);

  @override
  State<FuncionarioForm> createState() => _FuncionarioFormState();
}

class _FuncionarioFormState extends State<FuncionarioForm> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController cpf = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();
  TextEditingController grupoAcesso = TextEditingController();
  bool visibilidadeConfirmarSenha = false;
  bool visibilidadeSenha = false;

  bool preenchido = false;
  dynamic argument;

  MaskTextInputFormatter cpfMask = MaskTextInputFormatter(mask: "###.###.###-##");

  Funcionario funcionario = Funcionario();

  List<GrupoAcesso> gruposAcesso = [];
  GrupoAcesso? grupoAcessoSelecionado;
  bool gruposAcessoLoading = false;

  fetchFuncionario() async {
    funcionario = await FuncionariosController().getFuncionarioById(context, argument);
    cpf.text = funcionario.cpf;
    nome.text = funcionario.nome;
    email.text = funcionario.email;
    grupoAcessoSelecionado = funcionario.grupoAcesso;
    grupoAcesso.text = funcionario.grupoAcesso == null ? '' : funcionario.grupoAcesso!.nome;
    setState((){});
  }

  fetchGruposAcesso() async {
    setState(() => gruposAcessoLoading = true);
    gruposAcesso = await GruposAcessoController().getGruposAcesso(context);
    setState(() => gruposAcessoLoading = false);
  }

  @override
  void initState() {
    fetchGruposAcesso();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!preenchido)
    {
      argument = ModalRoute.of(context)!.settings.arguments;
      if(argument.runtimeType == int)
      {
        argument = ModalRoute.of(context)!.settings.arguments;
        fetchFuncionario();
      }
      preenchido = true;
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Funcionario'),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight - 18,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: DefaultTextFormField(
                          controller: cpf,
                          labelText: 'CPF',
                          keyboardType: TextInputType.number,
                          inputFormatters: [cpfMask],
                          onChanged: (data) => funcionario.cpf = cpfMask.getUnmaskedText(),
                        ),
                      ),
                      Flexible(
                        child: DefaultTextFormField(
                          controller: nome,
                          labelText: 'Nome',
                          onChanged: (data) => funcionario.nome = data,
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
                          itens: gruposAcesso.map((grupoAcesso){
                            return DropdownMenuItem(
                              value: grupoAcesso.nome,
                              child: Text(grupoAcesso.nome),
                              onTap: () => funcionario.grupoAcesso = grupoAcesso,
                            );
                          }).toList(),
                        ),
                      ),
                      Flexible(
                        child: DefaultTextFormField(
                          controller: email,
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (data) => funcionario.email = data,
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
                          obscureText: !visibilidadeSenha,
                          onChanged: (data) => funcionario.senha = data,
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
                            if(funcionario.senha != null)
                            {
                              if (value == null || value.isEmpty) {
                                return 'Digite algum valor';
                              }
                              else if(value.length < 6)
                              {
                                return 'A Senha deve ter no mínimo 6 caracteres';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      Flexible(
                        child: DefaultTextFormField(
                          controller: confirmarSenha,
                          labelText: 'Confirmar Senha',
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
                          validator: (value) {
                            if(funcionario.senha != null)
                            {
                              if (value == null || value.isEmpty) {
                                return 'Digite algum valor';
                              }
                              else if(value != senha.text)
                              {
                                return 'Os campos "Confirmar Senha" e "Senha" devem ser iguais';
                              }
                              else if(value.length < 6)
                              {
                                return 'A Senha deve ter no minimo 6 caracteres';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
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
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate())
                {
                  FuncionariosController request = FuncionariosController();
                  if(funcionario.id == null)
                  {
                    await request.postFuncionario(context, funcionario);
                  }
                  else
                  {
                    await request.updateFuncionario(context, funcionario);
                  }

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
                    Navigator.pop(context);
                  }
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
    );
  }
}