import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ResponseQuestion {
  String topicName;
  bool hasAnswer;
  int topicScore;
  int topicAnswer;
  List<String> topicTag;
  int questionId;

  ResponseQuestion(
      {this.topicName,
      this.hasAnswer,
      this.topicScore,
      this.topicAnswer,
      this.questionId,
      this.topicTag});

  static List<String> parseTags(tagsJson) {
    List<String> parseTags = new List<String>.from(tagsJson);
    return parseTags;
  }

  factory ResponseQuestion.fromJson(Map<String, dynamic> json) {
    return ResponseQuestion(
        topicName: json['title'],
        hasAnswer: json['is_answered'],
        topicScore: json['score'],
        topicAnswer: json['answer_count'],
        questionId: json['question_id'],
        topicTag: parseTags(json['tags'])
    );
  }
}
