import 'package:json_annotation/json_annotation.dart';
part 'package:flutter_app/models/bash/ResponseImage.g.dart';


@JsonSerializable()
class ResponseImage {
  @JsonKey(name: "icon_url")
  String iconUrl;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "audience")
  String audience;

  ResponseImage(this.iconUrl, this.name, this.audience);
  factory ResponseImage.fromJson(Map<String, dynamic> json) => _$ResponseImageFromJson(json);
}
