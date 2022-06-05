
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/material_model.dart';
import 'funcionario_atual_controller.dart';

class MateriaisController
{

  String error = '';

  Future<List<MaterialModel>> getMateriais(BuildContext context, [Map? material]) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'material',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows'].map<MaterialModel>((material) => MaterialModel.fromJson(material)).toList();
  }

  Future<MaterialModel> getMaterialById(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().get(
      endPoint: 'material/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return MaterialModel.fromJson(response.body['data']);
  }

  Future<bool> deleteMaterial(BuildContext context, int id) async
  {
    ApiResponse response = await ApiClient().delete(
      endPoint: 'material/$id',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
    );
    
    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<MaterialModel?> updateMaterial(BuildContext context, MaterialModel material) async
  {
    ApiResponse response = await ApiClient().put(
      endPoint: 'material',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: material.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return material;
    }
    return null;
  }

  Future<MaterialModel?> postMaterial(BuildContext context, MaterialModel material) async
  {
    ApiResponse response = await ApiClient().post(
      endPoint: 'material',
      token: Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().tokenApi,
      data: material.toJson(),
    );
    
    if(response.statusCode > 299)
    {
      response.body['error'].forEach((requestError){
        error += requestError['msg'] + "\n";
      });
    }
    else
    {
      return material;
    }
    return null;
  }

}