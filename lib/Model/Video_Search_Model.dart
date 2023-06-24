// To parse this JSON data, do
//
//     final VideoSearchModel = videoSerachModelFromJson(jsonString);

import 'dart:convert';

VideoSearchModel videoSerachModelFromJson(String str) => VideoSearchModel.fromJson(json.decode(str));

String videoSerachModelToJson(VideoSearchModel data) => json.encode(data.toJson());

class VideoSearchModel {
  int id;
  int width;
  int height;
  int duration;
  dynamic fullRes;
  List<dynamic> tags;
  String url;
  String image;
  dynamic avgColor;
  User user;
  List<VideoFile> videoFiles;
  List<VideoPicture> videoPictures;

  VideoSearchModel({
    required this.id,
    required this.width,
    required this.height,
    required this.duration,
    this.fullRes,
    required this.tags,
    required this.url,
    required this.image,
    this.avgColor,
    required this.user,
    required this.videoFiles,
    required this.videoPictures,
  });

  factory VideoSearchModel.fromJson(Map<String, dynamic> json) => VideoSearchModel(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    duration: json["duration"],
    fullRes: json["full_res"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    url: json["url"],
    image: json["image"],
    avgColor: json["avg_color"],
    user: User.fromJson(json["user"]),
    videoFiles: List<VideoFile>.from(json["video_files"].map((x) => VideoFile.fromJson(x))),
    videoPictures: List<VideoPicture>.from(json["video_pictures"].map((x) => VideoPicture.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "duration": duration,
    "full_res": fullRes,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "url": url,
    "image": image,
    "avg_color": avgColor,
    "user": user.toJson(),
    "video_files": List<dynamic>.from(videoFiles.map((x) => x.toJson())),
    "video_pictures": List<dynamic>.from(videoPictures.map((x) => x.toJson())),
  };
}

class User {
  int id;
  String name;
  String url;

  User({
    required this.id,
    required this.name,
    required this.url,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}

class VideoFile {
  int id;
  String quality;
  String fileType;
  int width;
  int height;
  double fps;
  String link;

  VideoFile({
    required this.id,
    required this.quality,
    required this.fileType,
    required this.width,
    required this.height,
    required this.fps,
    required this.link,
  });

  factory VideoFile.fromJson(Map<String, dynamic> json) => VideoFile(
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

class VideoPicture {
  int id;
  int nr;
  String picture;

  VideoPicture({
    required this.id,
    required this.nr,
    required this.picture,
  });

  factory VideoPicture.fromJson(Map<String, dynamic> json) => VideoPicture(
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
