// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:flutter_app/src/models/ItemModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
      page: json['page'] as int,
      total_results: json['total_results'] as int,
      total_pages: json['total_pages'] as int,
      results: (json['results'] as List)
          ?.map((e) => e == null
              ? null
              : ResultModels.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'page': instance.page,
      'total_results': instance.total_results,
      'total_pages': instance.total_pages,
      'results': instance.results
    };
