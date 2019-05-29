import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/ResultModels.dart';

class MovieBuilderList{
  Widget buildList(
      List<ResultModels> movies, BuildContext context, var _listController) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Image.network(
                    'https://image.tmdb.org/t/p/w185${movies[index].posterPath}',
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.low,
                  ),
                  Center(
                    child: Text(
                      movies[index].title,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              );
            },
            childCount: movies.length,
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
}
