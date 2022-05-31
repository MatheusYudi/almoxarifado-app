import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/funcionario_atual_controller.dart';
import '../model/funcionario_atual.dart';
import '../util/routes.dart';
import 'menu.dart';
import 'drawer_menu_itens.dart';

class DefaultUserDrawer extends StatelessWidget {
  const DefaultUserDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Menu(
      user: {
        'profilePicture':'https://picsum.photos/200',
        'name': Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionaroAtual().nome,
        'email': Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionaroAtual().email,
      },
      pages: MenuItensList.itens,
      footer: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 70)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.logout, color: Colors.white),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Logout', 
                //style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        onPressed: () {
          Provider.of<FuncionarioAtualController>(context, listen: false).setFuncionarioAtual(FuncionarioAtual());
          Navigator.pushReplacementNamed(context, Routes.login);
        },
      ),
    );
  }
}