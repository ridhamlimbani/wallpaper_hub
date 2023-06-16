import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub1/provider_helper/categorieProvider.dart';
import 'package:wallpaper_hub1/provider_helper/search_provider.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/string.dart';
import 'package:wallpaper_hub1/view/homeScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
        ChangeNotifierProvider<CategoriesProvider>(create: (_) => CategoriesProvider()),
      ],
      child: MaterialApp(
        title: AppString.appname,
        theme: ThemeData(
          primaryColor: AppColor.white,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    ),
  );
}
