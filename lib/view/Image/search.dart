import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/provider_helper/search_provider.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/images.dart';
import 'package:wallpaper_hub1/utils/string.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  bool isFabVisible = true;
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
          body:  Consumer<SearchProvider>(
            builder: (context,search,child){
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        autofocus: true,
                        enableSuggestions: true,
                        autocorrect: true,
                        onChanged: (String search1){
                          search.getSearchWallpapers(search1);
                        },
                        onSubmitted: (String search1){
                          search.getSearchWallpapers(search1);
                        },
                        cursorColor: AppColor.mainColor,
                        style: const TextStyle(fontFamily: "Fontmirror",color: AppColor.mainColor,decorationThickness: 0),
                        controller: search.searchController,
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
                  Expanded(
                    child: NotificationListener<UserScrollNotification>(
                      onNotification: (scrollInfo) {
                        if(scrollInfo.direction == ScrollDirection.forward){
                          setState(() {
                            isFabVisible=true;
                          });
                        }
                        else if(scrollInfo.direction==ScrollDirection.reverse){
                          setState(() {
                            isFabVisible=false;
                          });
                        }

                        if (!search.isLoading && scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          search.loadData(context,search.searchController.text.toString().trim());
                          search.setIsLoading(true);
                        }
                        return true;
                      },
                      child: wallpapersList(search.wallpaperList, context,search.scrollController),
                    ),
                  ),
                  Visibility(
                    visible: search.isLoading,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height  * 0.05,
                        child: Lottie.asset(AppLottie.loading,height: MediaQuery.of(context).size.height  * 0.05,width: 100),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: Consumer<SearchProvider>(
            builder: (context,search,child){
              return Visibility(
                visible: isFabVisible,
                child: FloatingActionButton(
                  backgroundColor: AppColor.mainColor,
                  onPressed: search.scrollUp,
                  child: const Icon(Icons.arrow_upward,color: AppColor.white,),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
