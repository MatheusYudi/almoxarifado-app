import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/material_model.dart';
import 'funcionario_atual_controller.dart';

class MateriaisController {
  String error = '';
  SharedPreferences? prefs;

  Future<List<MaterialModel>> getMateriais(BuildContext context,[Map? material]) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'material?page=1&size=1000&order=id&orderBy=DESC&status=Ativo',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }
    return response.body['data']['rows']
        .map<MaterialModel>((material) => MaterialModel.fromJson(material))
        .toList();
  }

  Future<MaterialModel> getMaterialById(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().get(
      endPoint: 'material/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }
    return MaterialModel.fromJson(response.body['data']);
  }

  Future<bool> deleteMaterial(BuildContext context, int id) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().delete(
      endPoint: 'material/$id',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
    );

    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }
    return true;
  }

  Future<MaterialModel?> updateMaterial(BuildContext context, MaterialModel material) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().put(
      endPoint: 'material',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: material.toJson(),
    );

    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return material;
    }
    return null;
  }

  Future<MaterialModel?> postMaterial(BuildContext context, MaterialModel material) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'material',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: material.toJson(),
    );

    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return material;
    }
    return null;
  }

//TODO confirmar qual email vai ser enviada a solicitação
  Future<bool> solicitarCompra(BuildContext context) async
  {
    prefs = await SharedPreferences.getInstance();
    ApiResponse response = await ApiClient().post(
      endPoint: 'material/purchase-request',
      token: jsonDecode(prefs!.getString('funcionario')?? '')['token'],
      data: {
        "email": Provider.of<FuncionarioAtualController>(context, listen: false)
            .getFuncionarioAtual()
            .email,
      },
    );

    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return true;
    }
    return false;
  }
}
