import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/provider_helper/search_provider.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/string.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  String searchTitle;
  SearchScreen({Key? key,required this.searchTitle}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   ScrollController _controller=ScrollController();


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
            title: brandName(),
          ),
          body: SingleChildScrollView(
            child: Consumer<SearchProvider>(
              builder: (context,child,search){
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          enableSuggestions: true,
                          autocorrect: true,
                          onChanged: (String search){
                            child.getSearchWallpapers(search);
                          },
                          onSubmitted: (String search){
                            child.getSearchWallpapers(search);
                          },
                          cursorColor: AppColor.mainColor,
                          style: const TextStyle(fontFamily: "Fontmirror",color: AppColor.mainColor,decorationThickness: 0),
                          controller: child.searchController,
                          decoration: InputDecoration(
                              hintText: "Search Categories",
                              hintStyle: const TextStyle(fontFamily: "Fontmirror",color: AppColor.mainColor),
                              contentPadding: const EdgeInsets.only(left: 20),
                              suffixIcon: const Icon(Icons.search,color: AppColor.mainColor,),
                              filled: true,
                              fillColor: AppColor.mainColor.withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const  BorderSide(
                                      color: AppColor.mainColor
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const  BorderSide(
                                      color: AppColor.mainColor
                                  )
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    wallpapersList(child.wallpaperList, context,_controller),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
