import 'dart:convert';

import 'question.dart';

class Result {
  final Question question;
  final String answer;

  const Result({
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question.toMap(),
      'answer': answer,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      question: Question.fromMap(map['question'] as Map<String, dynamic>),
      answer: map['answer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) =>
      Result.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Result(question: $question, answer: $answer)';

  @override
  bool operator ==(covariant Result other) {
    if (identical(this, other)) return true;

    return other.question == question && other.answer == answer;
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;
}
