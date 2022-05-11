import 'package:flutter/material.dart';

import '../util/routes.dart';

class MenuItensList
{
  static List<DraweMenuItem> itens = [
    DraweMenuItem(
      text: const Text('Home', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.home, color: Colors.white),
      pageRoute: Routes.homePage,
    ),
    DraweMenuItem(
      text: const Text('Fornecedores', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.group_add, color: Colors.white),
      pageRoute: Routes.fornecedores,
    ),
    DraweMenuItem(
      text: const Text('Materiais', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.inventory_2, color: Colors.white),
      pageRoute: Routes.materiais,
    ),
    DraweMenuItem(
      text: const Text('Funcionarios', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.group_add, color: Colors.white),
      pageRoute: Routes.funcionarios,
    ),
    DraweMenuItem(
      text: const Text('Inventários', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.inventory_2, color: Colors.white),
      pageRoute: Routes.inventarios,
    ),
    DraweMenuItem(
      text: const Text('Requisições', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.inventory_2, color: Colors.white),
      pageRoute: Routes.requisicoes,
    ),
  ];
}

class DraweMenuItem{
  final Text? text;
  final Icon? icon;
  final String pageRoute;
  final List<DraweMenuItem> children;

  DraweMenuItem({
    this.text,
    this.icon,
    this.pageRoute = '',
    this.children = const []
  }):assert(
    (children.isEmpty && pageRoute != '')
    || (children.isNotEmpty && pageRoute == '')
  );
}