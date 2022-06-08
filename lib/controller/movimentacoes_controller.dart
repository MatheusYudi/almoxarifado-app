import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/movimentacao.dart';
import 'funcionario_atual_controller.dart';

class MovimentacoesController
{

  String error = '';

  Future<List<Movimentacao>> getMovimentacoes(BuildContext context, [Map? movimentacao]) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'movement',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      filters: {'status': 'Ativo'},
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Movimentacao>((movimentacao) => Movimentacao.fromJson(movimentacao)).toList();
  }

  Future<Movimentacao> getMovimentacaoById(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'movement/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Movimentacao.fromJson(response.body['data']);
  }

  Future<bool> deleteMovimentacao(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().delete(
      endPoint: 'movement/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<Movimentacao?> updateMovimentacao(BuildContext context, Movimentacao movimentacao) async
  {
    ApiResponse response = await ApiClient().put(
      endPoint: 'movement',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
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
    ApiResponse response = await ApiClient().post(
      endPoint: 'movement',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
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