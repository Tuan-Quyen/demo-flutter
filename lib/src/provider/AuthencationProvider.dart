import 'package:dio/dio.dart';
import 'package:flutter_app/src/models/AuthencationModels.dart';
import 'package:flutter_app/src/models/ErrorModels.dart';

import 'BaseUrl.dart';

class AuthencationProvider {
  Future<String> getSessionId() async {
    final response = await BaseUrl().dio.get("authentication/token/new",
        queryParameters: {"api_key": BaseUrl.apiKey});
    if (response.statusCode == 200) {
      print("reponse : " + response.data.toString());
      var sessionId = response.data['request_token'] as String;
      return sessionId;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<AuthencationModels> requestLogin(
      String userName, String passWord) async {
    Map<String, String> map = {'content-type': 'application/json'};
    return await getSessionId().then((sessionId) async {
      Map<String, String> dataMap = {
        'username': userName,
        'password': passWord,
        'request_token': sessionId
      };
      final response = await BaseUrl().dio.post(
          "authentication/token/validate_with_login",
          queryParameters: {"api_key": BaseUrl.apiKey},
          data: dataMap,
          options: Options(headers: map));
      if (response.statusCode == 200) {
        print(response.data.toString());
        return AuthencationModels.fromJson(response.data);
      }
    });
  }
}
