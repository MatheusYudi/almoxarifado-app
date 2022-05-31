import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/funcionario.dart';
import 'funcionario_atual_controller.dart';

class FuncionariosController
{
  Future<List<Funcionario>> getFuncionarios(BuildContext context, [Map? funcionario]) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'user',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Funcionario>((funcionario) => Funcionario.fromJson(funcionario)).toList();
  }

  Future<Funcionario> getFuncionarioById(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'user/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Funcionario.fromJson(response.body['data']);
  }

  Future<bool> deleteFuncionario(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().delete(
      endPoint: 'user/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<Funcionario> updateFuncionario(BuildContext context, Funcionario funcionario) async
  {
    ApiResponse response = await ApiClient().put(
      endPoint: 'user',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: funcionario.toJson(),
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return funcionario;
  }

  Future<Funcionario> postFuncionario(BuildContext context, Funcionario funcionario) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'user',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: funcionario.toJson(),
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return funcionario;
  }

}