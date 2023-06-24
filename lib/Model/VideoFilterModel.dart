// To parse this JSON data, do
//
//     final videoFilterModel = videoFilterModelFromJson(jsonString);

import 'dart:convert';

VideoFilterModel videoFilterModelFromJson(String str) => VideoFilterModel.fromJson(json.decode(str));

String videoFilterModelToJson(VideoFilterModel data) => json.encode(data.toJson());

class VideoFilterModel {
  int id;
  String quality;
  String fileType;
  int width;
  int height;
  double fps;
  String link;

  VideoFilterModel({
    required this.id,
    required this.quality,
    required this.fileType,
    required this.width,
    required this.height,
    required this.fps,
    required this.link,
  });

  factory VideoFilterModel.fromJson(Map<String, dynamic> json) => VideoFilterModel(
    id: json["id"],
    quality: json["quality"],
    fileType: json["file_type"],
    width: json["width"],
    height: json["height"],
    fps: json["fps"]?.toDouble(),
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quality": quality,
    "file_type": fileType,
    "width": width,
    "height": height,
    "fps": fps,
    "link": link,
  };
}
