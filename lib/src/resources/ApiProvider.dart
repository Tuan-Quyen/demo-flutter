import 'dart:async';
import '../models/ItemModels.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  static BaseOptions options = new BaseOptions(
      baseUrl: "http://api.themoviedb.org/3/movie/",
      connectTimeout: 5000,
      receiveTimeout: 3000);
  Dio dio = Dio(options);

  Future<ItemModel> fetchMovieList(int _page) async {
    Map<String, String> map = {
      "api_key": "4d560f483fdb51909f54bc37635d7a2c",
      "page": _page.toString()
    };
    final response = await dio.get("popular", queryParameters: map);
    if (response.statusCode == 200) {
      print("reponse : " + response.data.toString());
      return ItemModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
