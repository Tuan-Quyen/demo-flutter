import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ResponseQuestion {
  String topicName;
  bool hasAnswer;

  ResponseQuestion({this.topicName, this.hasAnswer});

  factory ResponseQuestion.fromJson(Map<String, dynamic> json) {
    return ResponseQuestion(
        topicName: json["title"],
        hasAnswer: json["is_answered"]
    );
  }
}
