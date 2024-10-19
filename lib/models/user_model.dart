// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String gender;
  String yourClass;
  int age;
  String nation;
  int familyCount;
  int familyNumber;
  String familyType;

  UserModel({
    required this.name,
    required this.gender,
    required this.yourClass,
    required this.age,
    required this.nation,
    required this.familyCount,
    required this.familyNumber,
    required this.familyType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    gender: json["gender"],
    yourClass: json["your_class"],
    age: json["age"],
    nation: json["nation"],
    familyCount: json["family_count"],
    familyNumber: json["family_number"],
    familyType: json["family_type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "your_class": yourClass,
    "age": age,
    "nation": nation,
    "family_count": familyCount,
    "family_number": familyNumber,
    "family_type": familyType,
  };
}
