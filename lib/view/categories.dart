import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/provider_helper/categorieProvider.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/string.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';
import 'package:http/http.dart' as http;

class CategoriesScreen extends StatefulWidget {
  String categoriesTitle;

  CategoriesScreen({Key? key, required this.categoriesTitle}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoriesProvider categories;
  List<WallpaperModel> wallpaperList = [];

  int _page=1;
  final int _limit=20;
  bool _isFirstLoadRunning=false;
  bool _isLoadMoreRunning=false;
  bool _hasNextPage=true;

  void _loadMore() async{
    if(_hasNextPage == true && _isFirstLoadRunning ==false && _isLoadMoreRunning==false){
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page +=1;

      try{
        var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=${widget.categoriesTitle}&per_page=$_limit&page=$_page"),
            headers: {
              "Authorization":AppString.apikey,
            });

        print("Data :- ${response.body.toString()}");

        Map<String,dynamic> jsonData=jsonDecode(response.body);
        jsonData["photos"].forEach((element){

          WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
          wallpaperList.add(wallpaperModel);

          setState(() {});
        });

      }catch(error){
        if(kDebugMode){
          print("Something went wrong");
        }
      }


      setState(() {
        _isLoadMoreRunning=false;
      });

    }
  }

  void _firstLoad()async{
    setState(() {
      _isFirstLoadRunning = true;
    });

    try{
      var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=${widget.categoriesTitle}&per_page=$_limit&page=$_page"),
          headers: {
            "Authorization":AppString.apikey,
          });

      print("Data :- ${response.body.toString()}");

      Map<String,dynamic> jsonData=jsonDecode(response.body);
      jsonData["photos"].forEach((element){

        WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
        wallpaperList.add(wallpaperModel);

        setState(() {});
      });
    }catch(error){
      if(kDebugMode){
        print("Something went wrong");
      }
    }

    setState(() {
      _isFirstLoadRunning=false;
    });
  }
  late ScrollController _controller;

  @override
  void initState() {
    _firstLoad();
    _controller=ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              widget.categoriesTitle.toString(),
              style: const TextStyle(
                  color: AppColor.purple,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Fontmirror"),
            ),
          ),
          body:  _isLoadMoreRunning
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                wallpapersList(wallpaperList, context,_controller),
                if(_isLoadMoreRunning == true)
                  const Padding(padding: EdgeInsets.only(top: 10,bottom: 40),child: Center(child: CircularProgressIndicator(),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
