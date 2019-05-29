import 'dart:async';
import 'package:flutter_app/src/models/ResultModels.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/ItemModels.dart';

class MovieProvider {
  Client client = Client();
  final _apiKey = '4d560f483fdb51909f54bc37635d7a2c';
  final _baseUrl = 'http://api.themoviedb.org/3/movie';

  Future<List<ResultModels>> fetchMovieList(String _type,int _page) async {
    print("entered");
    final response = await client
        .get("$_baseUrl/$_type?api_key=$_apiKey&page=$_page");
    if (response.statusCode == 200) {
      print("reponse : " + response.body.toString());
      return ItemModel.fromJson(json.decode(response.body)).results;
    } else {
      throw Exception('Failed to load post');
    }
  }
}