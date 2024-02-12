import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pictorama/auth/api_response_helper.dart';
import 'package:pictorama/core/error/exceptions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiBaseHelper {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? 'https://www.google.com';
  final String apiKey = dotenv.env['API_KEY'] ?? 'xxxx';

  Future<ApiResponse<T>> get<T>(
    String endPoint,
  ) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse(
            _baseUrl + endPoint,
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Version': 'v1',
            'Authorization': 'Client-ID $apiKey'
          });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson =
            ApiResponse.success(json.decode(response.body.toString()));
        debugPrint(responseJson.toString());
        return responseJson;
      case 400:
        return ApiResponse.error(BadRequestException(response.body.toString()));
      case 401:
      case 403:
        return ApiResponse.error(
            UnauthorisedException(response.body.toString()));
      case 500:
      default:
        return ApiResponse.error(FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}'));
    }
  }
}
