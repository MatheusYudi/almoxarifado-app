import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../controller/funcionario_atual_controller.dart';
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
  static const String requisicaoForm = '/requisicacForm';
  static const String grupos = '/grupos';
  static const String movimentacoes = '/movimentacoes';
  static const String gerenciarEntrada = '/gerenciarEntrada';
  static const String entradaForm = '/entradaForm';
  static const String selecionarMaterial = '/selecionarMaterial';
  static const String selecionarFornecedor = '/selecionarFornecedor';
  static const String alterarSenha = '/alterarSenha';
  static const String avaliarRequisicao = '/avaliarRequisicao';

  static Map<String, WidgetBuilder> getRoutes(BuildContext context){
    String token = Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi;
    return {
      login: (context) => const LoginView(),
      homePage : (context) => token.isEmpty ? const LoginView() : const HomePageView(),
      fornecedores: (context)=> token.isEmpty ? const LoginView() : const Fornecedores(),
      fornecedorForm: (context)=> token.isEmpty ? const LoginView() : const FornecedorForm(),
      materiais: (context)=> token.isEmpty ? const LoginView() : const Materiais(),
      materialForm: (context)=> token.isEmpty ? const LoginView() : const MaterialForm(),
      funcionarios: (context)=> token.isEmpty ? const LoginView() : const Funcionarios(),
      funcionarioForm: (context)=> token.isEmpty ? const LoginView() : const FuncionarioForm(),
      inventarios: (context)=> token.isEmpty ? const LoginView() : const Inventarios(),
      inventarioForm: (context)=> token.isEmpty ? const LoginView() : const InventarioForm(),
      requisicoes: (context)=> token.isEmpty ? const LoginView() : const Requisicoes(),
      requisicaoForm: (context)=> token.isEmpty ? const LoginView() : const RequisicaoForm(),
      grupos: (context)=> token.isEmpty ? const LoginView() : const Grupos(),
      movimentacoes: (context)=> token.isEmpty ? const LoginView() : const Movimentacoes(),
      gerenciarEntrada: (context)=> token.isEmpty ? const LoginView() : const GerenciarEntrada(),
      entradaForm: (context)=> token.isEmpty ? const LoginView() : const EntradaForm(),
      selecionarMaterial: (context) => token.isEmpty ? const LoginView() : const SelecionarMaterial(),
      selecionarFornecedor: (context) => token.isEmpty ? const LoginView() : const SelecionarFornecedor(),
      alterarSenha: (context) => token.isEmpty ? const LoginView() : const AlterarSenha(),
      avaliarRequisicao: (context) => token.isEmpty ? const LoginView() : const AvaliarRequisicao(),
    };
  }

}