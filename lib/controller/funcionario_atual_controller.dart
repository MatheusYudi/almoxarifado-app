import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/funcionario_atual.dart';
import 'dart:html' as html;

class FuncionarioAtualController extends ChangeNotifier
{
  FuncionarioAtual funcionarioAtual = FuncionarioAtual();
  String error = '';
  bool loading = false;

  getFuncionarioAtual() => funcionarioAtual; 

  setFuncionarioAtual(FuncionarioAtual funcionario) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    funcionarioAtual = funcionario;
    await prefs.setString('funcionario', jsonEncode(funcionario.toJson()));
    notifyListeners();
  }

  recuperarSenha(BuildContext context, String email) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'auth/recover',
      data: {
        'email' : email,
        'resetUrl' : '${html.window.location.hostname}/#/alterarSenha'
      }
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
  }

  alterarSenha(BuildContext context, String senha, String token) async {
    ApiResponse response = await ApiClient().resetPassword(
      endPoint: 'auth/reset',
      token: token,
      data: {'password' : senha}
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
  }

}