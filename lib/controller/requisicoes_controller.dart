import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/requisicao.dart';

class RequisicoesController{
  String error = '';
  SharedPreferences? prefs;

  Future<List<Requisicao>> getRequisicoes(BuildContext context, [Map? requisicao]) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'requisition?page=1&size=1000&order=id&orderBy=DESC',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Requisicao>((requisicao) => Requisicao.fromJson(requisicao)).toList();
  }

  Future<Requisicao> getRequisicaoById(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'requisition/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Requisicao.fromJson(response.body['data']);
  }

  Future<bool> deleteRequisicao(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().delete(
      endPoint: 'requisition/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<Requisicao?> updateRequisicao(BuildContext context, Requisicao requisicao) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().put(
      endPoint: 'requisition',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
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
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'requisition',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
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
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'requisition/$id/approve',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode > 299)
    {
      if (response.body['error']['value'].isNotEmpty) {
        error = response.body['error']['message'] + ":\n";

        response.body['error']['value'].forEach((requestError){
          error += "- " + requestError + "\n";
        });
      } else {
        response.body['error'].forEach((requestError){
          error += requestError['msg'] + "\n";
        });
      }
    }
    else
    {
      return false;
    }
    return true;
  }

  Future<Map<String, dynamic>?> getBalanco(BuildContext context) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'requisition/balance',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return response.body['data'];
    }
    return null;
  }
}