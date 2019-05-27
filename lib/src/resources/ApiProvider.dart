import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/ItemModels.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = '4d560f483fdb51909f54bc37635d7a2c';

  Future<ItemModel> fetchMovieList(int _page) async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&page=$_page");
    if (response.statusCode == 200) {
      print("reponse : " + response.body.toString());
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}