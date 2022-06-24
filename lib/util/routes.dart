import 'package:flutter/cupertino.dart';

import '../view/alterar_senha.dart';
import '../view/fornecedor/fornecedor_form.dart';
import '../view/fornecedor/selecionar_fornecedor.dart';
import '../view/funcionario/funcionario_form.dart';
import '../view/funcionario/funcionarios_list.dart';
import '../view/grupo/grupos_material_list.dart';
import '../view/home_page.dart';
import '../view/inventario/inventario_form.dart';
import '../view/inventario/inventarios.dart';
import '../view/login.dart';
import '../view/fornecedor/fornecedores_list.dart';
import '../view/material/materiais_list.dart';
import '../view/material/material_form.dart';
import '../view/movimentacao/gerenciar_entrada.dart';
import '../view/movimentacao/entrada_form.dart';
import '../view/movimentacao/movimentacoes.dart';
import '../view/requisicao/avaliar_requisicao.dart';
import '../view/requisicao/requisicoes.dart';
import '../view/requisicao/requisicao_form.dart';
import '../view/material/selecionar_material.dart';

class Routes{
  static const String homePage = '/homePage';
  static const String login = '/login';
  static const String fornecedores = '/fornecedores';
  static const String fornecedorForm = '/fornecedorForm';
  static const String materiais = '/materiais';
  static const String materialForm = '/materialForm';
  static const String funcionarios = '/funcionarios';
  static const String funcionarioForm = '/funcionarioForm';
  static const String inventarios = '/inventarios';
  static const String inventarioForm = '/inventarioForm';
  static const String requisicoes = '/requisicoes';
  static const String requisicaoForm = '/requisicaoForm';
  static const String grupos = '/grupos';
  static const String movimentacoes = '/movimentacoes';
  static const String gerenciarEntrada = '/gerenciarEntrada';
  static const String entradaForm = '/entradaForm';
  static const String selecionarMaterial = '/selecionarMaterial';
  static const String selecionarFornecedor = '/selecionarFornecedor';
  static const String alterarSenha = '/alterarSenha';
  static const String avaliarRequisicao = '/avaliarRequisicao';

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      login: (context) => const LoginView(),
      homePage : (context) => const HomePageView(),
      fornecedores: (context)=> const Fornecedores(),
      fornecedorForm: (context)=> const FornecedorForm(),
      materiais: (context)=> const Materiais(),
      materialForm: (context)=> const MaterialForm(),
      funcionarios: (context)=> const Funcionarios(),
      funcionarioForm: (context)=> const FuncionarioForm(),
      inventarios: (context)=> const Inventarios(),
      inventarioForm: (context)=> const InventarioForm(),
      requisicoes: (context)=> const Requisicoes(),
      requisicaoForm: (context)=> const RequisicaoForm(),
      grupos: (context)=> const Grupos(),
      movimentacoes: (context)=> const Movimentacoes(),
      gerenciarEntrada: (context)=> const GerenciarEntrada(),
      entradaForm: (context)=> const EntradaForm(),
      selecionarMaterial: (context) => const SelecionarMaterial(),
      selecionarFornecedor: (context) => const SelecionarFornecedor(),
      alterarSenha: (context) => const AlterarSenha(),
      avaliarRequisicao: (context) => const AvaliarRequisicao(),
    };
  }

}