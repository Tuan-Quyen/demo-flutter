import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Owner {
  final String iconUrl;
  final String name;

  Owner({this.iconUrl, this.name});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(name: json['display_name'], iconUrl: json['profile_image']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'profile_image': iconUrl,
        'display_name': name,
      };
}
