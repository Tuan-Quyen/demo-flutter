// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:flutter_app/src/models/ResultModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultModels _$ResultModelsFromJson(Map<String, dynamic> json) {
  return ResultModels(
      vote_count: json['vote_count'] as int,
      id: json['id'] as int,
      video: json['video'] as bool,
      vote_average: json['vote_average'],
      title: json['title'] as String,
      popularity: (json['popularity'] as num)?.toDouble(),
      poster_path: json['poster_path'] as String,
      original_language: json['original_language'] as String,
      original_title: json['original_title'] as String,
      genre_ids: (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
      backdrop_path: json['backdrop_path'] as String,
      adult: json['adult'] as bool,
      overview: json['overview'] as String,
      release_date: json['release_date'] as String);
}

Map<String, dynamic> _$ResultModelsToJson(ResultModels instance) =>
    <String, dynamic>{
      'vote_count': instance.vote_count,
      'id': instance.id,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'title': instance.title,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'genre_ids': instance.genre_ids,
      'backdrop_path': instance.backdrop_path,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.release_date
    };
