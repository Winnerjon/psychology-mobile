// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

import 'package:psychology_mobile/models/result_model.dart';

SavedResultModel savedResultModelFromJson(String str) => SavedResultModel.fromJson(json.decode(str));

String savedResultModelToJson(SavedResultModel data) => json.encode(data.toJson());

class SavedResultModel {
  DateTime? date;
  List<ResultModel>? result;

  SavedResultModel({
    this.date,
    this.result,
  });

  factory SavedResultModel.fromJson(Map<String, dynamic> json) => SavedResultModel(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    result: json["result"] == null ? [] : List<ResultModel>.from(json["result"]!.map((x) => ResultModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "result": result == null ? [] : List<ResultModel>.from(result!.map((x) => x.toJson())),
  };
}