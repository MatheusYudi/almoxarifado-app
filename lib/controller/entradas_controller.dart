import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/entrada_model.dart';
import 'funcionario_atual_controller.dart';

class EntradasController{
  String error = '';
  SharedPreferences? prefs;

  Future<List<EntradaModel>> getEntradas(BuildContext context, [Map? entrada]) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'invoice?page=1&size=1000&order=id&orderBy=DESC',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<EntradaModel>((entrada) => EntradaModel.fromJson(entrada)).toList();
  }

  Future<EntradaModel> getEntradaModelById(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'invoice/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return EntradaModel.fromJson(response.body['data']);
  }

  Future<bool> deleteEntradaModel(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().delete(
      endPoint: 'invoice/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<EntradaModel?> updateEntradaModel(BuildContext context, EntradaModel entrada) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().put(
      endPoint: 'invoice',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
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
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'invoice',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
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