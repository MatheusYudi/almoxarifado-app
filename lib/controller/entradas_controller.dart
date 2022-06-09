import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/entrada_model.dart';
import 'funcionario_atual_controller.dart';

class EntradasController{
  String error = '';

  Future<List<EntradaModel>> getEntradas(BuildContext context, [Map? entrada]) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'invoice',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<EntradaModel>((entrada) => EntradaModel.fromJson(entrada)).toList();
  }

  Future<EntradaModel> getEntradaModelById(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'invoice/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return EntradaModel.fromJson(response.body['data']);
  }

  Future<bool> deleteEntradaModel(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().delete(
      endPoint: 'invoice/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<EntradaModel?> updateEntradaModel(BuildContext context, EntradaModel entrada) async
  {
    ApiResponse response = await ApiClient().put(
      endPoint: 'invoice',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: entrada.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return entrada;
    }
    return null;
  }

  Future<EntradaModel?> postEntradaModel(BuildContext context, EntradaModel entrada) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'invoice',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: entrada.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return entrada;
    }
    return null;
  }
}