abstract class MovieEvent {}

class PopularEvent extends MovieEvent {
  final int page;
  final String type;

  PopularEvent({this.type, this.page}) : assert(page != null && page != 0);
}
