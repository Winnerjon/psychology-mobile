// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

import 'package:psychology_mobile/models/option_model.dart';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  int? questionnaire;
  int? number;
  String? question;
  OptionModel? answer;

  QuizModel({
    this.questionnaire,
    this.number,
    this.question,
    this.answer,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        questionnaire: json["questionnaire"],
        number: json["number"],
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "questionnaire": questionnaire,
        "number": number,
        "question": question,
      };

  QuizModel copyWith({
    int? questionnaire,
    int? number,
    String? question,
    OptionModel? answer,
  }) {
    return QuizModel(
        questionnaire: questionnaire ?? this.questionnaire,
        number: number ?? this.number,
        question: question ?? this.question,
        answer: answer ?? this.answer);
  }
}
