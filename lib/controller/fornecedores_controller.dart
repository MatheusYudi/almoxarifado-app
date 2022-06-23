import 'dart:convert';

import 'package:almoxarifado/model/funcionario_atual.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/fornecedor.dart';
import 'funcionario_atual_controller.dart';

class FornecedoresController
{
  String error = '';
  SharedPreferences? prefs;
  Future<List<Fornecedor>> getFornecedores(BuildContext context, [Map? fornecedor]) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'supplier?page=1&size=1000&order=id&orderBy=DESC&status=Ativo',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Fornecedor>((fornecedor) => Fornecedor.fromJson(fornecedor)).toList();
  }

  Future<Fornecedor> getFornecedorById(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'supplier/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Fornecedor.fromJson(response.body['data']);
  }

  Future<bool> deleteFornecedor(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().delete(
      endPoint: 'supplier/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<Fornecedor> updateFornecedor(BuildContext context, Fornecedor fornecedor) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().put(
      endPoint: 'supplier',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
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
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'supplier',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
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