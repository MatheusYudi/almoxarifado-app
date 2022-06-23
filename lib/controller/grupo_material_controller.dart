import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/grupo_material.dart';
import 'funcionario_atual_controller.dart';

class GruposMaterialController
{

  String error = '';
  SharedPreferences? prefs;

  Future<List<GrupoMaterial>> getGruposMaterial(BuildContext context, [Map? grupoMaterial]) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'material-group?page=1&size=1000&order=id&orderBy=DESC&status=Ativo',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<GrupoMaterial>((grupoMaterial) => GrupoMaterial.fromJson(grupoMaterial)).toList();
  }

  Future<GrupoMaterial> getGrupoMaterialById(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'material-group/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return GrupoMaterial.fromJson(response.body['data']);
  }

  Future<bool> deleteGrupoMaterial(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().delete(
      endPoint: 'material-group/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<GrupoMaterial?> updateGrupoMaterial(BuildContext context, GrupoMaterial grupoMaterial) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().put(
      endPoint: 'material-group',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: grupoMaterial.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return grupoMaterial;
    }
    return null;
  }

  Future<GrupoMaterial?> postGrupoMaterial(BuildContext context, GrupoMaterial grupoMaterial) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'material-group',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: grupoMaterial.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return grupoMaterial;
    }
    return null;
  }

}