import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/funcionario_atual.dart';

class FuncionarioAtualController extends ChangeNotifier
{
  FuncionarioAtual funcionarioAtual = FuncionarioAtual();
  String error = '';
  bool loading = false;

  getFuncionarioAtual() => funcionarioAtual; 

  setFuncionarioAtual(FuncionarioAtual funcionario) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    funcionarioAtual = funcionario;
    await prefs.setString('token', funcionario.tokenApi);
    notifyListeners();
  }

  recuperarSenha(BuildContext context, String email) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'auth/recover',
      data: {
        'email' : email,
        'resetUrl' : 'https://almoxarifado-app-staging.vercel.app/#/alterarSenha'
      }
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
  }

  alterarSenha(BuildContext context, String senha) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'auth/reset',
      // TODO: usar o token do link do email e enviar como x-reset-token no header
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
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