import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/funcionario_atual_controller.dart';
import '../model/funcionario_atual.dart';
import '../util/routes.dart';
import 'menu.dart';
import 'drawer_menu_itens.dart';

class DefaultUserDrawer extends StatefulWidget {
  const DefaultUserDrawer({ Key? key }) : super(key: key);

  @override
  State<DefaultUserDrawer> createState() => _DefaultUserDrawerState();
}

class _DefaultUserDrawerState extends State<DefaultUserDrawer> {

  SharedPreferences? prefs;

  getPreferences() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Menu(
      user: prefs == null ? {} : {
        'profilePicture':'https://picsum.photos/200',
        'name': jsonDecode(prefs!.getString('funcionario')?? '')['name'],
        'email': jsonDecode(prefs!.getString('funcionario')?? '')['email'],
      },
      pages: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().grupoAcesso == null
      ? MenuItensList.itens
      : Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().grupoAcesso.nome == "Funcionário"
      ? MenuItensList.funcionarioItens
      : Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().grupoAcesso.nome == "Requisitante"
      ? MenuItensList.requisitanteItens
      : MenuItensList.itens,
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
        onPressed: () async {
          Provider.of<FuncionarioAtualController>(context, listen: false).setFuncionarioAtual(FuncionarioAtual());
          Navigator.pushReplacementNamed(context, Routes.login);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', '');
        },
      ),
    );
  }
}