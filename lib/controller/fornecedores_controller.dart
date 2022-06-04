import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/fornecedor.dart';
import 'funcionario_atual_controller.dart';

class FornecedoresController
{
  String error = '';
  Future<List<Fornecedor>> getFornecedores(BuildContext context, [Map? fornecedor]) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'supplier',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Fornecedor>((fornecedor) => Fornecedor.fromJson(fornecedor)).toList();
  }

  Future<Fornecedor> getFornecedorById(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'supplier/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Fornecedor.fromJson(response.body['data']);
  }

  Future<bool> deleteFornecedor(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().delete(
      endPoint: 'supplier/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<Fornecedor> updateFornecedor(BuildContext context, Fornecedor fornecedor) async
  {
    ApiResponse response = await ApiClient().put(
      endPoint: 'supplier',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: fornecedor.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      throw Exception(response.body['error']);
    }
    return fornecedor;
  }

  Future<Fornecedor?> postFornecedor(BuildContext context, Fornecedor fornecedor) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'supplier',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: fornecedor.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return fornecedor;
    }
    return null;
  }

}