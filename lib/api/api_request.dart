import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_response.dart';

enum RequestType {
  // ignore: constant_identifier_names
  GET,
  // ignore: constant_identifier_names
  POST,
  // ignore: constant_identifier_names
  DELETE,
  // ignore: constant_identifier_names
  PUT,
}

class ApiRequest
{
  String url;
  RequestType requestType;
  dynamic body;
  Map<String, String>? header;
  dynamic params;

  ApiRequest({
    required this.url,
    required this.requestType,
    this.body,
    this.header,
    this.params,
  });

  Future<ApiResponse> makeCall() async
  {

    http.Response response;

    if(params != null)
    {
      if(params.runtimeType == String)
      {
        params = jsonDecode(params);
      }

      url = url + '?';
      params?.forEach((key, value) {
        url = url + '$key=$value&';
      });
      url = url.substring(0, (url.length-1));
    }

    Uri parsedUrl = Uri.parse(url);

    switch(requestType)
    {
      case RequestType.GET:
        response = await http.get(parsedUrl, headers: header);
        break;
      case RequestType.POST:
        response = await http.post(
          parsedUrl,
          headers: header,
          body: body,
        );
        break;
      case RequestType.DELETE:
        response = await http.delete(
          parsedUrl,
          headers: header,
          body: body,
        );
        break;
      case RequestType.PUT:
        response = await http.put(
          parsedUrl,
          headers: header,
          body: body,
        );
        break;
    }

      ApiResponse apiResponse = ApiResponse(
        body: response.body == '' ? response.body : jsonDecode(response.body),
        header: response.headers,
        statusCode: response.statusCode,
      );
      return apiResponse;
  }

}