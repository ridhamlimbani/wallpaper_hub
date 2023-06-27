import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/utils/string.dart';
import 'package:wallpaper_hub1/view/Image/homeScreen.dart';
import 'package:wallpaper_hub1/view/Video/videoHomeScreen.dart';
import 'package:wallpaper_hub1/view/WelComeScreen/PhotoWelcomeScreen.dart';
import 'package:wallpaper_hub1/view/WelComeScreen/VideoWelComeScreen.dart';

class HomeProvider extends ChangeNotifier{
  final List<WallpaperModel> _wallpaperList = [];

  int _page = 1;

  final int _limit = 16;

  bool _isLoading = false;

  bool _isFabVisible = true;

  final ScrollController _scrollController=ScrollController();

  List<WallpaperModel> get wallpaperList => _wallpaperList;

  int get page => _page;

  int get limit => _limit;

  bool get isFabVisible => _isFabVisible;

  bool get isLoading => _isLoading;

  ScrollController get scrollController => _scrollController;

  void setIsLoading(bool isValue){
    _isLoading = isValue;
    notifyListeners();
  }

  void setVisible(bool isValue){
     _isFabVisible = isValue;
    notifyListeners();
  }

  void scrollUp(){
    const double start=0;

    _scrollController.animateTo(start, duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  void handleClick(int item,BuildContext context) {
    switch (item) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const PhotoWelComeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const VideoWelComeScreen()));
        break;
    }
  }


  Future loadData(BuildContext context)async{
    await Future.delayed(const Duration(seconds: 2));

    print("Load More Data ...........");
    _page +=1;

    try{
      var response = await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=$_limit&page=$_page"),
          headers: {
            "Authorization":AppString.apikey,
          });

      print("Data :- ${response.body.toString()}");

      Map<String,dynamic> jsonData=jsonDecode(response.body);
      jsonData["photos"].forEach((element){

        WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
        _wallpaperList.add(wallpaperModel);

        _isLoading=false;


        notifyListeners();


      });

    }catch(error){
      if(kDebugMode){
        print("Something went wrong");
      }
    }

  }

  getCategoriesWallpapers() async {
    _wallpaperList.clear();
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=$_limit&page=$_page"),
        headers: {
          "Authorization": AppString.apikey,
        });

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
      _wallpaperList.add(wallpaperModel);
      notifyListeners();
    });
  }
}