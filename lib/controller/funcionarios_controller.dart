import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/funcionario.dart';
import '../model/requisicao.dart';

class FuncionariosController
{

  String error = '';
  SharedPreferences? prefs;

  Future<List<Funcionario>> getFuncionarios(BuildContext context, [Map? funcionario]) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'user?page=1&size=1000&order=id&orderBy=DESC&status=Ativo',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Funcionario>((funcionario) => Funcionario.fromJson(funcionario)).toList();
  }

  Future<Funcionario> getFuncionarioById(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'user/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return Funcionario.fromJson(response.body['data']);
  }

  Future<bool> deleteFuncionario(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().delete(
      endPoint: 'user/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
      return false;
    }
    return true;
  }

  Future<Funcionario?> updateFuncionario(BuildContext context, Funcionario funcionario) async
  {
    prefs = await SharedPreferences.getInstance();
    Map funcionarioAtualizado = funcionario.toJson();
  
    if (funcionario.senha == null) {
      funcionarioAtualizado.remove('password');
    }

    ApiResponse response = await ApiClient().put(
      endPoint: 'user',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: funcionarioAtualizado,
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return funcionario;
    }
    return null;
  }

  Future<Funcionario?> postFuncionario(BuildContext context, Funcionario funcionario) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'user',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: funcionario.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return funcionario;
    }
    return null;
  }

  Future<List<Requisicao>> getRequisicoes(BuildContext context, Funcionario funcionario) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'user/${funcionario.id}/requisition?page=1&size=1000&order=id&orderBy=DESC',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<Requisicao>((requisicao) => Requisicao.fromJson(requisicao)).toList();
  }
}