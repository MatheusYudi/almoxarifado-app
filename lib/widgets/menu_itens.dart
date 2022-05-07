import 'package:flutter/material.dart';

import '../util/routes.dart';

class MenuItensList
{
  static List<MenuItem> itens = [
    MenuItem(
      text: const Text('Home', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.home, color: Colors.white),
      pageRoute: Routes.homePage,
    ),
    MenuItem(
      text: const Text('Fornecedores', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.group_add, color: Colors.white),
      pageRoute: Routes.fornecedores,
    ),
    MenuItem(
      text: const Text('Materiais', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.inventory_2, color: Colors.white),
      pageRoute: Routes.materiais,
    ),
    MenuItem(
      text: const Text('Funcionarios', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.group_add, color: Colors.white),
      pageRoute: Routes.funcionarios,
    ),
  ];
}

class MenuItem{
  final Text? text;
  final Icon? icon;
  final String pageRoute;
  final List<MenuItem> children;

  MenuItem({
    this.text,
    this.icon,
    this.pageRoute = '',
    this.children = const []
  }):assert(
    (children.isEmpty && pageRoute != '')
    || (children.isNotEmpty && pageRoute == '')
  );
}