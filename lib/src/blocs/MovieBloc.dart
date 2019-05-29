import 'package:bloc/bloc.dart';
import 'package:flutter_app/src/blocs/events/MovieEvent.dart';
import 'package:flutter_app/src/blocs/states/MovieState.dart';
import 'package:flutter_app/src/models/ResultModels.dart';
import 'package:flutter_app/src/responsitory/MovieResponsitory.dart';

class MoviesBloc extends Bloc<MovieEvent, MovieState> {
  final MovieResponsitory movieResponsitory;

  MoviesBloc({this.movieResponsitory}) : assert(movieResponsitory != null);

  @override
  MovieState get initialState => MovieUninitializedState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is PopularEvent) {
      if (event.page == 1) {
        yield MovieFetchingState();
      }
      try {
        final List<ResultModels> movies =
            await movieResponsitory.fetchMovieList(
                event.type != null ? event.type : "popular", event.page);
        if (movies.length == 0) {
          yield MovieEmptyState();
        } else {
          yield MovieFetchedState(results: movies);
        }
      } catch (_) {
        yield MovieErrorState();
      }
    }
  }
}
