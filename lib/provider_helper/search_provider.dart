import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub1/utils/string.dart';

class SearchProvider extends ChangeNotifier{
  List<WallpaperModel> _wallpaperList = [];
  TextEditingController _searchController=TextEditingController();
  int _page=0;


  List<WallpaperModel> get wallpaperList => _wallpaperList;
  TextEditingController get searchController => _searchController;
  int get page => _page;


  getSearchWallpapers(String query) async {
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