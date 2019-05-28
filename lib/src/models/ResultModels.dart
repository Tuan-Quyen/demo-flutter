import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_app/src/models/bash/ResultModels.g.dart';

@JsonSerializable()
class ResultModels {
  @JsonKey(name: "vote_count")
  int vote_count;
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "video")
  bool video;
  @JsonKey(name: "vote_average")
  var vote_average;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "popularity")
  double popularity;
  @JsonKey(name: "poster_path")
  String poster_path;
  @JsonKey(name: "original_language")
  String original_language;
  @JsonKey(name: "original_title")
  String original_title;
  @JsonKey(name: "genre_ids")
  List<int> genre_ids = [];
  @JsonKey(name: "backdrop_path")
  String backdrop_path;
  @JsonKey(name: "adult")
  bool adult;
  @JsonKey(name: "overview")
  String overview;
  @JsonKey(name: "release_date")
  String release_date;

  ResultModels(
      {this.vote_count,
      this.id,
      this.video,
      this.vote_average,
      this.title,
      this.popularity,
      this.poster_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.backdrop_path,
      this.adult,
      this.overview,
      this.release_date});

  factory ResultModels.fromJson(Map<String, dynamic> json) =>
      _$ResultModelsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelsToJson(this);
}
