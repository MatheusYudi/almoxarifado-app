import 'package:almoxarifado/api/api_client.dart';
import 'package:almoxarifado/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/funcionario_atual_controller.dart';
import '../model/funcionario_atual.dart';
import 'recuperar_senha.dart';

class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool passwordVisibility = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Wrap(
                      spacing: 90,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          width: 420,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children:  [
                              const Icon(
                                Icons.lightbulb_outline,
                                size: 100,
                                color: Colors.black,
                              ),
                              Text(
                                'Almoxarifado',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 200,
                          width: 2,
                        ),
                        SizedBox(
                          width: 420,
                          child: Text(
                            'OL??,\nBEM VINDO AO SISTEMA DO ALMOXARIFADO',
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.clip,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                    maxHeight: double.infinity
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [                    
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                          ),
                          child: TextFormField(
                            controller: loginController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Usu??rio',
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.person_rounded),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                          ),
                          child: TextFormField(
                            controller: senhaController,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.lock_rounded),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passwordVisibility = !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                  color: const Color(0xFF757575),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: loading 
                          ? const SizedBox(height: 15, width: 15,child: CircularProgressIndicator())
                          : const Text('Entrar'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green[600])
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            ApiClient  request = ApiClient();
                            request.post(
                              endPoint: 'auth/login',
                              data: {
                                'email': loginController.text,
                                'password': senhaController.text,
                              },
                            ).then((response) async {
                              setState(() {
                                loading = false;
                              });
                              if(response.statusCode == 200)
                              {
                                if(response.body['status'] == true)
                                {
                                  Navigator.pushNamed(context, Routes.homePage);
                                  Provider.of<FuncionarioAtualController>(context, listen: false).setFuncionarioAtual(FuncionarioAtual.fromJson(response.body['data']));
                                }
                              }
                              else
                              {
                                showDialog(
                                  context: context,
                                  builder: (context){
                                    return const AlertDialog(
                                      title: Text('Algo deu errado'),
                                      content: Text('Verifique os dados de login'),
                                    );
                                  },
                                );
                              }
                            });                            
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: const Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (context){
                                  return const RecuperarSenhaForm();
                                }
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}