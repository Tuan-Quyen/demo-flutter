import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_app/models/local/Owner.dart';

@JsonSerializable()
class ResponseQuestion {
  String topicName;
  bool hasAnswer;
  int topicScore;
  int topicAnswer;
  List<String> topicTag = new List();
  int questionId;
  int lastActivityDate;
  Owner owner;

  ResponseQuestion(
      {this.topicName,
      this.hasAnswer,
      this.topicScore,
      this.topicAnswer,
      this.questionId,
      this.topicTag,
      this.lastActivityDate,
      this.owner});

  factory ResponseQuestion.fromJson(Map<String, dynamic> json) {
    return ResponseQuestion(
        topicName: json['title'],
        hasAnswer: json['is_answered'],
        topicScore: json['score'],
        topicAnswer: json['answer_count'],
        questionId: json['question_id'],
        topicTag: List<String>.from(json['tags']) != null
            ? List<String>.from(json['tags'])
            : [],
        lastActivityDate: json['last_activity_date'],
        owner: Owner.fromJson(json['owner']));
  }
}
