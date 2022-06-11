import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/requisicao.dart';
import 'funcionario_atual_controller.dart';

class RequisicoesController{
  String error = '';

  Future<List<Requisicao>> getRequisicoes(BuildContext context, [Map? requisicao]) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'requisition?page=1&size=1000&order=id&orderBy=DESC',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Requisicao>((requisicao) => Requisicao.fromJson(requisicao)).toList();
  }

  Future<Requisicao> getRequisicaoById(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'requisition/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Requisicao.fromJson(response.body['data']);
  }

  Future<bool> deleteRequisicao(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().delete(
      endPoint: 'requisition/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<Requisicao?> updateRequisicao(BuildContext context, Requisicao requisicao) async
  {
    ApiResponse response = await ApiClient().put(
      endPoint: 'requisition',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: requisicao.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return requisicao;
    }
    return null;
  }

  Future<Requisicao?> postRequisicao(BuildContext context, Requisicao requisicao) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'requisition',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: requisicao.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return requisicao;
    }
    return null;
  }

  Future<bool> finalizarRequisicao(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'requisition/$id/approve',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return false;
    }
    return true;
  }
}