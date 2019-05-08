import 'package:json_annotation/json_annotation.dart';
part 'package:flutter_app/models/bash/ResponseUserImage.g.dart';

@JsonSerializable()
class ResponseUserImage{
  @JsonKey(name: "profile_image")
  String profileImage;

  ResponseUserImage(this.profileImage);
  factory ResponseUserImage.fromJson(Map<String, dynamic> json) => _$ResponseUserImageFromJson(json);
}