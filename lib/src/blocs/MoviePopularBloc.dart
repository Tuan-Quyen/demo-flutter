import '../resources/Repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/ItemModels.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies(int _page) async {
    ItemModel itemModel = await _repository.fetchAllMovies(_page);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();