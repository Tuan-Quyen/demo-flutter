import 'package:flutter_app/src/models/ResultModels.dart';
import 'package:flutter_app/src/provider/MovieProvider.dart';

class MovieResponsitory {
  MovieProvider _movieProvider = MovieProvider();

  Future<List<ResultModels>> fetchMovieList(String _type,int _page) =>
      _movieProvider.fetchMovieList(_type,_page);
}
