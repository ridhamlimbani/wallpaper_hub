import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/view/imageView.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        "Wallpaper",
        style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Fontmirror"),
      ),
      Text(
        "Hub",
        style: TextStyle(
            color: AppColor.purple,
            fontWeight: FontWeight.bold,
            fontFamily: "Fontmirror"),
      ),
    ],
  );
}

Widget wallpaperShimmer() {
  return FancyShimmerImage(
    imageUrl: "",
    shimmerBaseColor:
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    shimmerHighlightColor:
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    shimmerBackColor:
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    errorWidget: Container(
      color: Colors.transparent,
    ),
  );
}

Widget wallpapersList(List<WallpaperModel> wallpapers, context,ScrollController scrollController) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      itemCount: wallpapers.length +1,
      shrinkWrap: true,
      gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
      ),
     itemBuilder: (context,index){
        if(index < wallpapers.length){
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageView(imgUrl: wallpapers[index].src.portrait),
                ),
              );
            },
            child: Hero(
              tag: wallpapers[index].src.portrait,
              child: GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      memCacheHeight: 1024,
                      memCacheWidth: 1024,
                      imageUrl: wallpapers[index].src.portrait,
                      placeholder: (context, url) => wallpaperShimmer(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          );
        }else{
          return const Padding(padding: EdgeInsets.symmetric(vertical: 32));
        }
     },
    ),
  );
}
