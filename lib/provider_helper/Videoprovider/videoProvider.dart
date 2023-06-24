import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub1/view/Image/homeScreen.dart';
import 'package:wallpaper_hub1/view/Video/videoHomeScreen.dart';

class VideoHomeProvider extends ChangeNotifier{

  void handleClick(int item,BuildContext context) {
    switch (item) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const VideoHomeScreen()));
        break;
    }
  }
}