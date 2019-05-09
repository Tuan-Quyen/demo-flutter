import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Owner {
  String iconUrl;
  String name;

  String get getName => name;

  set setName(String name) {
    this.name = name;
  }

  String get getIcon => iconUrl;

  set setIcon(String icon) {
    iconUrl = icon;
  }

  Owner({this.iconUrl, this.name});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(name: json['display_name'], iconUrl: json['profile_image']);
  }
}
