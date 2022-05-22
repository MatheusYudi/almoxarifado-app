import 'package:flutter/cupertino.dart';

import '../view/funcionarioForm.dart';
import '../view/funcionarios.dart';
import '../view/grupos.dart';
import '../view/home_page.dart';
import '../view/inventario_form.dart';
import '../view/inventarios.dart';
import '../view/login.dart';
import '../view/fornecedores.dart';
import '../view/materiais.dart';
import '../view/materialForm.dart';
import '../view/movimentacoes.dart';
import '../view/requisicoes.dart';
import '../view/requisicoes_form.dart';
import '../view/selecionar_material.dart';

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