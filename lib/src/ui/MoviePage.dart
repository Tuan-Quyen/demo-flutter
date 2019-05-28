import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/MoviePopularBloc.dart';
import 'package:flutter_app/src/models/ItemModels.dart';
import 'package:flutter_app/src/models/ResultModels.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  var _listController = ScrollController();
  int _page = 1;
  List<ResultModels> _listMovie = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie Popular",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            _listMovie.addAll(snapshot.data.results);
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Image.network(
                    'https://image.tmdb.org/t/p/w185${_listMovie[index].poster_path}',
                  ),
                  Center(
                    child: Text(
                      _listMovie[index].title,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              );
            },
            childCount: _listMovie.length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.1)),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
      controller: _listController,
      scrollDirection: Axis.vertical,
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void _listener() {
    if (_listController.position.pixels ==
        _listController.position.maxScrollExtent) {
      _page++;
      bloc.fetchAllMovies(_page);
    }
  }

  @override
  void initState() {
    bloc.fetchAllMovies(_page);
    _listController.addListener(_listener);
    super.initState();
  }
}
