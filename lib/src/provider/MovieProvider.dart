import 'dart:async';
import 'package:flutter_app/src/models/ResultModels.dart';
import 'package:flutter_app/src/provider/BaseUrl.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/ItemModels.dart';

class MovieProvider {
  Client client = Client();
  final _apiKey = BaseUrl.apiKey;
  final _baseUrl = BaseUrl.baseUrl;

  Future<List<ResultModels>> fetchMovieList(String _type,int _page) async {
    final response = await client
        .get("$_baseUrl/movie/$_type?api_key=$_apiKey&page=$_page");
    print("$_baseUrl/movie/$_type?api_key=$_apiKey&page=$_page");
    if (response.statusCode == 200) {
      print("reponse : " + response.body.toString());
      return ItemModel.fromJson(json.decode(response.body)).results;
    } else {
      throw Exception('Failed to load movie');
    }
  }
}