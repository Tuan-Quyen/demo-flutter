import '../resources/Repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/ItemModels.dart';
import 'dart:async';

class MoviesRxBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies =>
      _moviesFetcher.stream.transform(_transform);

  var _transform = StreamTransformer<ItemModel, ItemModel>.fromHandlers(
      handleData: (data, sink) {
    for (int i = 0; i < 3; i++) {
      data.results[i].title = "Stream Transformer Test";
    }
    sink.add(data);
  });

  fetchAllMovies(int _page) async {
    ItemModel itemModel = await _repository.fetchAllMovies(_page);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}
