// To parse this JSON data, do
//
//     final newUserModel = newUserModelFromJson(jsonString);

import 'dart:convert';

NewUserModel newUserModelFromJson(String str) => NewUserModel.fromJson(json.decode(str));

String newUserModelToJson(NewUserModel data) => json.encode(data.toJson());

class NewUserModel {
  int id;
  String token;

  NewUserModel({
    required this.id,
    required this.token,
  });

  factory NewUserModel.fromJson(Map<String, dynamic> json) => NewUserModel(
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
  };
}
