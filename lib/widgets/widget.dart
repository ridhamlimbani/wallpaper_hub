import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper_hub1/Model/Video_Search_Model.dart';
import 'package:wallpaper_hub1/Model/VideopictureModel.dart';
import 'dart:math' as math;
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/view/Image/imageView.dart';
import 'package:wallpaper_hub1/view/Video/VideoPlayerList.dart';

Widget brandName() {
  return RichText(
    text: const TextSpan(
      children: [
        TextSpan(
          text:"Wallpaper",
          style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "Fontmirror"),
        ),
        TextSpan(
          text:"Hub",
          style: TextStyle(
              color: AppColor.purple,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "Fontmirror"),
        ),
      ],
    ),
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

Widget wallpapersList(List<WallpaperModel> wallpapers, context,ScrollController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
      physics: const ClampingScrollPhysics(),
      controller: controller,
      itemCount: wallpapers.length,
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
                  builder: (context) => imageView(wallpaperModel: wallpapers[index],),
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

Widget videoWallpapersList(List<VideoSearchModel> videoWallpapers, context,ScrollController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
      physics: const ClampingScrollPhysics(),
      controller: controller,
      itemCount: videoWallpapers.length,
      shrinkWrap: true,
      gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
      ),
     itemBuilder: (context,index){
        if(index < videoWallpapers.length){
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerList(videoUrl: videoWallpapers[index].videoFiles[3].link)));
            },
            child: Hero(
              tag: videoWallpapers[index].videoFiles[1].link,
              child: GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      memCacheHeight: 1024,
                      memCacheWidth: 1024,
                      imageUrl: videoWallpapers[index].videoPictures[1].picture,
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
