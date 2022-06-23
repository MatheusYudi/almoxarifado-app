import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/grupo_acesso.dart';
import 'funcionario_atual_controller.dart';

class GruposAcessoController
{
  SharedPreferences? prefs;

  Future<List<GrupoAcesso>> getGruposAcesso(BuildContext context, [Map? grupoAcesso]) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'access-group?page=1&size=1000&order=id&orderBy=DESC',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<GrupoAcesso>((grupoAcesso) => GrupoAcesso.fromJson(grupoAcesso)).toList();
  }

  Future<GrupoAcesso> getGrupoAcessoById(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'access-group/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return GrupoAcesso.fromJson(response.body['data']);
  }

  Future<bool> deleteGrupoAcesso(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().delete(
      endPoint: 'access-group/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<GrupoAcesso> updateGrupoAcesso(BuildContext context, GrupoAcesso grupoAcesso) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().put(
      endPoint: 'access-group',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: grupoAcesso.toJson(),
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return grupoAcesso;
  }

  Future<GrupoAcesso> postGrupoAcesso(BuildContext context, GrupoAcesso grupoAcesso) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'access-group',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: grupoAcesso.toJson(),
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return grupoAcesso;
  }

}