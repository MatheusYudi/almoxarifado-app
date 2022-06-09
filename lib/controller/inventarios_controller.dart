import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/inventario.dart';
import 'funcionario_atual_controller.dart';

class InventariosController{
  
  String error = '';

  Future<List<Inventario>> getInventarios(BuildContext context, [Map? inventario]) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'inventory?page=1&size=1000&orderBy=ASC',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Inventario>((inventario) => Inventario.fromJson(inventario)).toList();
  }

  Future<Inventario> getInventarioById(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'inventory/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Inventario.fromJson(response.body['data']);
  }

  Future<bool> deleteInventario(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().delete(
      endPoint: 'inventory/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<Inventario?> updateInventario(BuildContext context, Inventario inventario) async
  {
    ApiResponse response = await ApiClient().put(
      endPoint: 'inventory',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: inventario.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return inventario;
    }
    return null;
  }

  Future<Inventario?> postInventario(BuildContext context, Inventario inventario) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'inventory',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: inventario.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return inventario;
    }
    return null;
  }

  Future<bool> finalizarInventario(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'inventory/$id/close',
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