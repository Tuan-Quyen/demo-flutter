import 'package:flutter_app/src/models/ResultModels.dart';

abstract class MovieState{}

class MovieUninitializedState extends MovieState{}

class MovieFetchingState extends MovieState{}

class MovieFetchedState extends MovieState{
  final List<ResultModels> results;

  MovieFetchedState({this.results}) : assert(results != null);
}

class MovieErrorState extends MovieState{}

class MovieEmptyState extends MovieState{}