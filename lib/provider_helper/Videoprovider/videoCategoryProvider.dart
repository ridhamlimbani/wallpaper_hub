import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub1/Model/VideoFilterModel.dart';
import 'package:wallpaper_hub1/Model/Video_Search_Model.dart';
import 'package:wallpaper_hub1/Model/VideopictureModel.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub1/utils/string.dart';

class VideoCategoryProvider extends ChangeNotifier{
  final List<VideoSearchModel> _wallpaperList = [];

  final List<VideoFilterModel> _videoFilterList = [];

  final List<VideoPictureModel> _videoPictureList = [];

  int _page = 1;

  final int _limit = 16;

  bool _isLoading = false;

  final ScrollController _scrollController=ScrollController();

  List<VideoSearchModel> get wallpaperList => _wallpaperList;

  List<VideoFilterModel> get videoFilterList => _videoFilterList;

  List<VideoPictureModel> get videoPictureList => _videoPictureList;

  int get page => _page;

  int get limit => _limit;

  bool get isLoading => _isLoading;

  ScrollController get scrollController=> _scrollController;

  void setIsLoading(bool isValue){
    _isLoading = isValue;
    notifyListeners();
  }

  void scrollUp(){
    final double start=0;

    _scrollController.animateTo(start, duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  Future loadData(BuildContext context,String query)async{
    await Future.delayed(const Duration(seconds: 2));

    print("Load More Data ...........");
    _page +=1;

    try{
      var response = await http.get(Uri.parse("https://api.pexels.com/videos/search?query=$query&per_page=$limit"),
          headers: {
            "Authorization":AppString.apikey,
          });

      print("Data :- ${response.body.toString()}");

      Map<String,dynamic> jsonData=jsonDecode(response.body);
      for(int i =0;i<jsonData["videos"].length;i++){
        jsonData["videos"][i]["video_files"].forEach((element){
          VideoFilterModel videoFilterModel = VideoFilterModel.fromJson(element);
          _videoFilterList.add(videoFilterModel);
          notifyListeners();
        });

        jsonData["videos"][i]["video_pictures"].forEach((element){
          VideoPictureModel videoPictureModel = VideoPictureModel.fromJson(element);
          _videoPictureList.add(videoPictureModel);
          notifyListeners();
        });

        jsonData["videos"].forEach((element){
          VideoSearchModel wallpaperModel = VideoSearchModel.fromJson(element);
          _wallpaperList.add(wallpaperModel);
          notifyListeners();
        });
      }

    }catch(error){
      if(kDebugMode){
        print("Something went wrong");
      }
    }

  }

  getCategoriesWallpapers(String query) async {
    _wallpaperList.clear();
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/videos/search?query=$query&per_page=$limit"),
        headers: {
          "Authorization": AppString.apikey,
        });

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    for(int i =0;i<jsonData["videos"].length;i++){
      jsonData["videos"][i]["video_files"].forEach((element){
        VideoFilterModel videoFilterModel = VideoFilterModel.fromJson(element);
        _videoFilterList.add(videoFilterModel);
        notifyListeners();
      });

      jsonData["videos"][i]["video_pictures"].forEach((element){
        VideoPictureModel videoPictureModel = VideoPictureModel.fromJson(element);
        _videoPictureList.add(videoPictureModel);
        notifyListeners();
      });

      jsonData["videos"].forEach((element){
        VideoSearchModel wallpaperModel = VideoSearchModel.fromJson(element);
        _wallpaperList.add(wallpaperModel);
        notifyListeners();
      });
    }
  }
}