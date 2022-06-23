import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/movimentacao.dart';
import 'funcionario_atual_controller.dart';

class MovimentacoesController
{

  String error = '';
  SharedPreferences? prefs;

  Future<List<Movimentacao>> getMovimentacoes(BuildContext context, [Map? filters]) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: "movement?page=1&size=${filters != null ? filters['size'] : 1000}&order=id&orderBy=DESC",
      token: prefs!.getString('token') ?? '',
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Movimentacao>((movimentacao) => Movimentacao.fromJson(movimentacao)).toList();
  }

  Future<Movimentacao> getMovimentacaoById(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'movement/$id',
      token: prefs!.getString('token') ?? '',
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Movimentacao.fromJson(response.body['data']);
  }

  Future<bool> deleteMovimentacao(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().delete(
      endPoint: 'movement/$id/',
      token: prefs!.getString('token') ?? '',
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<Movimentacao?> updateMovimentacao(BuildContext context, Movimentacao movimentacao) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().put(
      endPoint: 'movement',
      token: prefs!.getString('token') ?? '',
      data: movimentacao.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return movimentacao;
    }
    return null;
  }

  Future<Movimentacao?> postMovimentacao(BuildContext context, Movimentacao movimentacao) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'movement',
      token: prefs!.getString('token') ?? '',
      data: movimentacao.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return movimentacao;
    }
    return null;
  }

}