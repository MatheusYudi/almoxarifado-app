import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/grupo_material.dart';
import 'funcionario_atual_controller.dart';

class GruposMaterialController
{
  Future<List<GrupoMaterial>> getGruposMaterial(BuildContext context, [Map? grupoMaterial]) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'material-group',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<GrupoMaterial>((grupoMaterial) => GrupoMaterial.fromJson(grupoMaterial)).toList();
  }

  Future<GrupoMaterial> getGrupoMaterialById(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'material-group/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return GrupoMaterial.fromJson(response.body['data']);
  }

  Future<bool> deleteGrupoMaterial(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().delete(
      endPoint: 'material-group/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<GrupoMaterial> updateGrupoMaterial(BuildContext context, GrupoMaterial grupoMaterial) async
  {
    ApiResponse response = await ApiClient().put(
      endPoint: 'material-group',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: grupoMaterial.toJson(),
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return grupoMaterial;
  }

  Future<GrupoMaterial> postGrupoMaterial(BuildContext context, GrupoMaterial grupoMaterial) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'material-group',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: grupoMaterial.toJson(),
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return grupoMaterial;
  }

}