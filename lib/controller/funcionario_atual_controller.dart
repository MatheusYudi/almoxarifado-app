import 'package:flutter/cupertino.dart';

import '../model/funcionario_atual.dart';

class FuncionarioAtualController extends ChangeNotifier
{
  FuncionarioAtual funcionarioAtual = FuncionarioAtual();
  bool error = false;
  bool loading = false;

  getFuncionarioAtual() => funcionarioAtual; 

  setFuncionarioAtual(FuncionarioAtual funcionario){
    funcionarioAtual = funcionario;
    notifyListeners();
  }
}