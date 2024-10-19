// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

ResultModel resultModelFromJson(String str) => ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  int? id;
  String? name;
  String? description;
  List<int>? questionnaire1;
  List<int>? questionnaire2;

  ResultModel({
    this.id,
    this.name,
    this.description,
    this.questionnaire1,
    this.questionnaire2,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    questionnaire1: json["questionnaire1"] == null ? [] : List<int>.from(json["questionnaire1"]!.map((x) => x)),
    questionnaire2: json["questionnaire2"] == null ? [] : List<int>.from(json["questionnaire2"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "questionnaire1": questionnaire1 == null ? [] : List<dynamic>.from(questionnaire1!.map((x) => x)),
    "questionnaire2": questionnaire2 == null ? [] : List<dynamic>.from(questionnaire2!.map((x) => x)),
  };

  ResultModel copyWith({
    int? id,
    String? name,
    String? description,
    List<int>? questionnaire1,
    List<int>? questionnaire2,
  }) {
    return ResultModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        questionnaire1: questionnaire1 ?? this.questionnaire1,
        questionnaire2: questionnaire2 ?? this.questionnaire2);
  }
}
