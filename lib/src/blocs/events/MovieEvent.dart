abstract class MovieEvent {}

class PopularEvent extends MovieEvent {
  final int page;

  PopularEvent({this.page}) : assert(page != null && page != 0);
}
