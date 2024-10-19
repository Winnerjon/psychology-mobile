// To parse this JSON data, do
//
//     final optionModel = optionModelFromJson(jsonString);

import 'dart:convert';

OptionModel optionModelFromJson(String str) => OptionModel.fromJson(json.decode(str));

String optionModelToJson(OptionModel data) => json.encode(data.toJson());

class OptionModel {
  int id;
  int type;
  String answer;

  OptionModel({
    required this.id,
    required this.type,
    required this.answer,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
    id: json["id"],
    type: json["type"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "answer": answer,
  };
}
