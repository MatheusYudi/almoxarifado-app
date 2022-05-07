import 'package:almoxarifado/util/routes.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
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
                      height: 100,
                      width: 2,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'OLÁ, BEM VINDO AO SISTEMA DO ALMOXARIFADO',
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.clip,
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [                    
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                    ),
                    child: TextFormField(
                      controller: loginController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Usuário',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_rounded),
                      ),
                    ),
                  ),
                  Container(
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
                  ElevatedButton(
                    child: const Text('Entrar'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green[600])
                    ),
                    onPressed: () => Navigator.pushNamed(context, Routes.homePage),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text(
                          'Não tenho cadastro',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (){},
                      ),
                      TextButton(
                        child: const Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (){},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}