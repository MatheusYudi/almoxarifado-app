import 'package:flutter/material.dart';

import '../api/api_request.dart';
import '../api/api_response.dart';
import '../model/ncm_model.dart';

class NcmController{
  String error = '';
  bool loading = false;

  Future<List<NcmModel>> getNcms(BuildContext context, [Map? ncm]) async
  {
    ApiRequest request = ApiRequest(
      url: 'https://ncm-ibpt-valid.herokuapp.com/json/sp',
      requestType: RequestType.GET,
    );
    request.header = {
      'Content-Type': 'application/json',
    };
    
    loading = true;
    ApiResponse response = await request.makeCall();
    loading = false;

    if(response.statusCode != 200)
    {
      throw Exception(response.body['error']);
    }
    
    return response.body.map<NcmModel>((ncm) => NcmModel.fromJson(ncm)).toList();
  }
}