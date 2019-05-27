import 'dart:async';
import 'ApiProvider.dart';
import '../models/ItemModels.dart';

class Repository {
  final moviesApiProvider = ApiProvider();

  Future<ItemModel> fetchAllMovies(int _page) => moviesApiProvider.fetchMovieList(_page);
}