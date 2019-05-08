// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:flutter_app/models/responses/ResponseImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseImage _$ResponseImageFromJson(Map<String, dynamic> json) {
  return ResponseImage(json['icon_url'] as String, json['name'] as String,
      json['audience'] as String);
}

Map<String, dynamic> _$ResponseImageToJson(ResponseImage instance) =>
    <String, dynamic>{
      'icon_url': instance.iconUrl,
      'name': instance.name,
      'audience': instance.audience
    };
