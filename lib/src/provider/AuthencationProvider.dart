import 'dart:convert';

import 'package:http/http.dart';

import 'BaseUrl.dart';

class AuthencationProvider {
  Client client = Client();
  final _apiKey = BaseUrl.apiKey;
  final _baseUrl = BaseUrl.baseUrl;

  Future<String> getSessionId() async {
    final response = await client
        .get("$_baseUrl/authentication/token/new?api_key=$_apiKey");
    print("$_baseUrl/authentication/token/new?api_key=$_apiKey");
    if (response.statusCode == 200) {
      print("reponse : " + response.body.toString());
      var sessionId = json.decode(response.body)['request_token'] as String;
      return sessionId;
    } else {
      throw Exception('Failed to load session id');
    }
  }

  Future<> requestLogin(String userName, String passWord) async {
    Map<String, String> map = {'content-type': 'application/json'};
    await getSessionId().then((sessionId) async {
      Map<String, String> dataMap = {'username': userName, 'password': passWord,'request_token':sessionId};
      final response = await client.post(
          "$_baseUrl/authentication/token/new?api_key=$_apiKey", headers: map,
          body: dataMap);
    });
  }
}