// To parse this JSON data, do
//
//     final videoPictureModel = videoPictureModelFromJson(jsonString);

import 'dart:convert';

VideoPictureModel videoPictureModelFromJson(String str) => VideoPictureModel.fromJson(json.decode(str));

String videoPictureModelToJson(VideoPictureModel data) => json.encode(data.toJson());

class VideoPictureModel {
  int id;
  int nr;
  String picture;

  VideoPictureModel({
    required this.id,
    required this.nr,
    required this.picture,
  });

  factory VideoPictureModel.fromJson(Map<String, dynamic> json) => VideoPictureModel(
    id: json["id"],
    nr: json["nr"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nr": nr,
    "picture": picture,
  };
}
