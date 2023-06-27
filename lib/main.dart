import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub1/provider_helper/Videoprovider/videoCategoryProvider.dart';
import 'package:wallpaper_hub1/provider_helper/Videoprovider/videoProvider.dart';
import 'package:wallpaper_hub1/provider_helper/Videoprovider/videoSearchProvider.dart';
import 'package:wallpaper_hub1/provider_helper/categorieProvider.dart';
import 'package:wallpaper_hub1/provider_helper/home_provider.dart';
import 'package:wallpaper_hub1/provider_helper/image_Provider.dart';
import 'package:wallpaper_hub1/provider_helper/search_provider.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/string.dart';
import 'package:wallpaper_hub1/view/splashScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
        ChangeNotifierProvider<CategoriesProvider>(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<ImageInfoProvider>(create: (_) => ImageInfoProvider()),
        ChangeNotifierProvider<VideoHomeProvider>(create: (_) => VideoHomeProvider()),
        ChangeNotifierProvider<VideoSearchProvider>(create: (_) => VideoSearchProvider()),
        ChangeNotifierProvider<VideoCategoryProvider>(create: (_) => VideoCategoryProvider()),
      ],
      child: MaterialApp(
        title: AppString.appname,
        theme: ThemeData(
          primaryColor: AppColor.white,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    ),
  );
}
