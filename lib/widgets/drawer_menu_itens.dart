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
      icon: const Icon(Icons.fire_truck, color: Colors.white),
      pageRoute: Routes.fornecedores,
    ),
    DraweMenuItem(
      text: const Text('Materiais', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.inventory, color: Colors.white),
      pageRoute: Routes.materiais,
    ),
    DraweMenuItem(
      text: const Text('Funcionários', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.group_add, color: Colors.white),
      pageRoute: Routes.funcionarios,
    ),    
    DraweMenuItem(
      text: const Text('Grupos', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.category, color: Colors.white),
      pageRoute: Routes.grupos,
    ),
    DraweMenuItem(
      text: const Text('Movimentações', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.swap_vert, color: Colors.white),
      children: [
        DraweMenuItem(
          text: const Text('Consultar Movimentações', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.sync, color: Colors.white),
          pageRoute: Routes.movimentacoes,
        ),
        DraweMenuItem(
          text: const Text('Entradas', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.file_download_outlined, color: Colors.white),
          pageRoute: Routes.gerenciarEntrada,
        ),
        DraweMenuItem(
          text: const Text('Requisições', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.file_upload_outlined, color: Colors.white),
          pageRoute: Routes.requisicoes,
        ),
        DraweMenuItem(
          text: const Text('Inventários', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.checklist, color: Colors.white),
          pageRoute: Routes.inventarios,
        ),
      ],
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