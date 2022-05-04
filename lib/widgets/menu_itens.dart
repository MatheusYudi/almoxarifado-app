import 'package:flutter/material.dart';

import '../util/routes.dart';

class MenuItensList
{
  static List<MenuItem> itens = [
    MenuItem(
      text: const Text('Home'),
      icon: Icons.home,
      pageRoute: Routes.homePage,
    ),
    MenuItem(
      text: const Text('Home'),
      icon: Icons.home,
      pageRoute: Routes.fornecedores,
    ),
  ];
}

class MenuItem{
  final Text? text;
  final IconData? icon; //tipo IconData para ter liberdade de usar o icone outros parametros em qualquer pagina
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