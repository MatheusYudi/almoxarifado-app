import 'package:flutter/cupertino.dart';

import '../view/funcionario/funcionarioForm.dart';
import '../view/funcionario/funcionarios.dart';
import '../view/grupo/grupos.dart';
import '../view/home_page.dart';
import '../view/inventario/inventario_form.dart';
import '../view/inventario/inventarios.dart';
import '../view/login.dart';
import '../view/fornecedor/fornecedores.dart';
import '../view/material/materiais.dart';
import '../view/material/materialForm.dart';
import '../view/movimentacao/movimentacoes.dart';
import '../view/requisicao/requisicoes.dart';
import '../view/requisicao/requisicoes_form.dart';
import '../view/material/selecionar_material.dart';

class Routes{
  static const String homePage = '/home_page';
  static const String login = '/login';
  static const String fornecedores = '/fornecedores';
  static const String materiais = '/materiais';
  static const String materialForm = '/materialForm';
  static const String funcionarios = '/funcionarios';
  static const String funcionarioForm = '/funcionarioForm';
  static const String inventarios = '/inventarios';
  static const String inventarioForm = '/inventarioForm';
  static const String requisicoes = '/requisicoes';
  static const String requisicoesForm = '/requisicoesForm';
  static const String grupos = '/grupos';
  static const String movimentacoes = '/movimentacoes';
  static const String selecionarMaterial = '/selecionarMaterial';

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      login: (context) => const LoginView(),
      homePage : (context) => const HomePageView(),
      fornecedores: (context)=> const Fornecedores(),
      materiais: (context)=> const Materiais(),
      materialForm: (context)=> const MaterialForm(),
      funcionarios: (context)=> const Funcionarios(),
      funcionarioForm: (context)=> const FuncionarioForm(),
      inventarios: (context)=> const Inventarios(),
      inventarioForm: (context)=> const InventarioForm(),
      requisicoes: (context)=> const Requisicoes(),
      requisicoesForm: (context)=> const RequisicoesForm(),
      grupos: (context)=> const Grupos(),
      movimentacoes: (context)=> const Movimentacoes(),
      selecionarMaterial: (context) => const SelecionarMaterial(),
    };
  }

}