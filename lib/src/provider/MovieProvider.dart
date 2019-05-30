import 'dart:async';
import 'package:flutter_app/src/models/ResultModels.dart';
import 'package:flutter_app/src/provider/BaseUrl.dart';
import '../models/ItemModels.dart';

class MovieProvider {
  Future<List<ResultModels>> fetchMovieList(String _type, int _page) async {
    Map<String, String> map = {
      "api_key": BaseUrl.apiKey,
      "page": _page.toString()
    };
    final response =
        await BaseUrl().dio.get("movie/$_type", queryParameters: map);
    print(response.request.uri);
    if (response.statusCode == 200) {
      print("reponse : " + response.data.toString());
      return ItemModel.fromJson(response.data).results;
    } else {
      throw Exception('Failed to load movie');
    }
  }
}
