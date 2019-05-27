import 'ResultModels.dart';
import 'package:json_annotation/json_annotation.dart';
part 'package:flutter_app/src/models/bash/ItemModels.g.dart';

@JsonSerializable()
class ItemModel {
  @JsonKey(name: "page")
  int page;
  @JsonKey(name: "total_results")
  int total_results;
  @JsonKey(name: "total_pages")
  int total_pages;
  @JsonKey(name: "results")
  List<ResultModels> results = [];

  ItemModel({this.page, this.total_results, this.total_pages, this.results});
  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
/*ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    _total_pages = parsedJson['total_pages'];
    List<ResultModels> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      ResultModels result = ResultModels(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }*/
}
