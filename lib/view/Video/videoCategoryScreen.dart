import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub1/provider_helper/Videoprovider/videoCategoryProvider.dart';
import 'package:wallpaper_hub1/provider_helper/Videoprovider/videoProvider.dart';
import 'package:wallpaper_hub1/provider_helper/categorieProvider.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/images.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';

class VideoCategoryScreen extends StatefulWidget {
  String categoriesTitle;

   VideoCategoryScreen({Key? key, required this.categoriesTitle}) : super(key: key);

  @override
  State<VideoCategoryScreen> createState() => _VideoCategoryScreenState();
}

class _VideoCategoryScreenState extends State<VideoCategoryScreen> {
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
            title: Text(
              widget.categoriesTitle,
              style: const TextStyle(
                  color: AppColor.purple,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Fontmirror"),
            ),
          ),
          body:  Consumer<VideoCategoryProvider>(
            builder: (context,categories,child){
              return Column(
                children: <Widget>[
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

                        if (!categories.isLoading && scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          categories.loadData(context,widget.categoriesTitle);
                          categories.setIsLoading(true);
                        }
                        return true;
                      },
                      child: videoWallpapersList(categories.wallpaperList, context,categories.scrollController),
                    ),
                  ),
                  Visibility(
                    visible: categories.isLoading,
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
          floatingActionButton: Consumer<CategoriesProvider>(
            builder: (context,categories,child){
              return Visibility(
                visible: isFabVisible,
                child: FloatingActionButton(
                  backgroundColor: AppColor.mainColor,
                  onPressed: categories.scrollUp,
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
