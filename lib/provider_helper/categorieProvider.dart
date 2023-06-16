import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub1/utils/string.dart';

class CategoriesProvider extends ChangeNotifier{
  List<WallpaperModel> _wallpaperList = [];
  int _page=1;
  final int _limit=20;
  bool _isFirstLoadRunning=false;
  bool _isLoadMoreRunning=false;
  bool _hasNextPage=true;
  ScrollController _controller=ScrollController();

  List<WallpaperModel> get wallpaperList => _wallpaperList;
  int get page => _page;
  int get limit => _limit;
  bool get isFirstLoadRunning => _isFirstLoadRunning;
  bool get isLoadMoreRunning => _isLoadMoreRunning;
  bool get hasNextPage => _hasNextPage;
  ScrollController get controller => _controller;

    void loadMore(String query) async{
    if(_hasNextPage == true && _isFirstLoadRunning ==false && _isLoadMoreRunning==false){

        _isLoadMoreRunning = true;
        notifyListeners();


      _page +=1;

      try{
        var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=$_limit&page=$_page"),
            headers: {
              "Authorization":AppString.apikey,
            });

        print("Data :- ${response.body.toString()}");

        Map<String,dynamic> jsonData=jsonDecode(response.body);
        jsonData["photos"].forEach((element){

          WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
          wallpaperList.add(wallpaperModel);

          notifyListeners();
        });

      }catch(error){
        if(kDebugMode){
          print("Something went wrong");
        }
      }


        _isLoadMoreRunning=false;

      notifyListeners();

    }
  }

   firstLoad(String query)async{
      _isFirstLoadRunning = true;
      notifyListeners();
    try{
      var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=$_limit&page=$_page"),
          headers: {
            "Authorization":AppString.apikey,
          });

      print("Data :- ${response.body.toString()}");

      Map<String,dynamic> jsonData=jsonDecode(response.body);
      jsonData["photos"].forEach((element){

        WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
        wallpaperList.add(wallpaperModel);

        notifyListeners();
      });
    }catch(error){
      if(kDebugMode){
        print("Something went wrong");
      }
    }


      _isFirstLoadRunning=false;

    notifyListeners();
  }


  getCategoriesWallpapers(String query) async {
    _wallpaperList.clear();
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=50&page=1"),
        headers: {
          "Authorization":AppString.apikey,
        });

    Map<String,dynamic> jsonData=jsonDecode(response.body);

    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
      _wallpaperList.add(wallpaperModel);
      notifyListeners();
    });
  }

}