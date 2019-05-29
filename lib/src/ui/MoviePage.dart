import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/MovieBloc.dart';
import 'package:flutter_app/src/blocs/events/MovieEvent.dart';
import 'package:flutter_app/src/blocs/states/MovieState.dart';
import 'package:flutter_app/src/models/GeneresModels.dart';
import 'package:flutter_app/src/models/ResultModels.dart';
import 'package:flutter_app/src/responsitory/MovieResponsitory.dart';
import 'package:flutter_app/src/ui/widgets/GeneresDialog.dart';
import 'package:flutter_app/src/ui/widgets/MovieBuilderList.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  var _listController = ScrollController();
  int _page = 1;
  List<ResultModels> _list = [];
  String type;

  static MovieResponsitory _movieResponsitory = MovieResponsitory();
  final MoviesBloc _moviesBloc =
      MoviesBloc(movieResponsitory: _movieResponsitory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Movie",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: Colors.black87,
          actions: <Widget>[GeneresDialog().buildPopupMenu(choiceAction)],
        ),
        body: BlocBuilder(
            bloc: _moviesBloc,
            builder: (context, state) {
              if (state is MovieFetchingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieErrorState) {
                return Center(
                  child: Text(
                    "Error",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                );
              } else if (state is MovieUninitializedState) {
                return Container();
              } else {
                final stateAsMovieFetchedState = state as MovieFetchedState;
                final movies = stateAsMovieFetchedState.results;
                return builderList(movies);
              }
            }));
  }

  Widget builderList(List<ResultModels> movies) {
    _list.addAll(movies);
    return MovieBuilderList().buildList(_list, context, _listController);
  }

  void _listener() {
    if (_listController.position.pixels ==
        _listController.position.maxScrollExtent) {
      _page++;
      _moviesBloc.dispatch(PopularEvent(type: type, page: _page));
    }
  }

  void choiceAction(GeneresModels choice) {
    _list.clear();
    type = choice.key;
    _page = 1;
    _moviesBloc.dispatch(PopularEvent(type: type, page: _page));
  }

  @override
  void initState() {
    _moviesBloc.dispatch(PopularEvent(type: type, page: _page));
    _listController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _moviesBloc.dispose();
    super.dispose();
  }
}
