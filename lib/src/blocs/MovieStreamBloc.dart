import '../resources/Repository.dart';
import '../models/ItemModels.dart';
import 'dart:async';

class MoviesStreamBloc {
  final _repository = Repository();

  StreamController _controller = new StreamController<ItemModel>();

  Stream<ItemModel> get movieStream => _controller.stream.transform(_transform);


  var _transform = StreamTransformer<ItemModel, ItemModel>.fromHandlers(
      handleData: (data, sink) {
        for (int i = 0; i < 3; i++) {
          data.results[i].title = "Stream Transformer Test";
        }
        sink.add(data);
      });

  fetchAllMovies(int _page) async {
    ItemModel itemModel = await _repository.fetchAllMovies(_page);
    _controller.sink.add(itemModel);
  }

  dispose() {
    _controller.close();
  }
}
