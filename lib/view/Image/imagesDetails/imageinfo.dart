import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/images.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';

class ImageInfoScreen extends StatefulWidget {
  WallpaperModel wallpaperModel;

  ImageInfoScreen({Key? key, required this.wallpaperModel}) : super(key: key);

  @override
  State<ImageInfoScreen> createState() => _ImageInfoScreenState();
}

class _ImageInfoScreenState extends State<ImageInfoScreen> {


  @override
  Widget build(BuildContext context) {

    String ageColor=widget.wallpaperModel.avgColor.toString().replaceFirst("#", "");

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: brandName(),
          centerTitle: true,
          backgroundColor: AppColor.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  maxRadius: 50,
                  backgroundColor: Color(int.parse("0xff$ageColor")).withOpacity(0.5),
                  backgroundImage: const AssetImage(AppImage.personImage),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(widget.wallpaperModel.photographer,style: const TextStyle(
                  color: AppColor.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Fontmirror"),),
              const SizedBox(
                height: 5,
              ),
              Text("Art :- ${widget.wallpaperModel.alt}",style: const TextStyle(
                  color: AppColor.black,
                  fontStyle: FontStyle.italic,
                  fontFamily: "Fontmirror"),),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
                      width: 2,
                      color: Color(int.parse("0xff$ageColor")))),
                  child: Column(
                    children: [
                      GridTile(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                            child: CachedNetworkImage(
                              memCacheHeight: 1024,
                              memCacheWidth: 1024,
                              imageUrl: widget.wallpaperModel.src.small,
                              placeholder: (context, url) => wallpaperShimmer(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )),
                      const Text("Small",style: TextStyle(
                          color: AppColor.black,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Fontmirror"),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
                      width: 2,
                      color: Color(int.parse("0xff$ageColor")))),
                  child: Column(
                    children: [
                      GridTile(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                            child: CachedNetworkImage(
                              memCacheHeight: 1024,
                              memCacheWidth: 1024,
                              imageUrl: widget.wallpaperModel.src.tiny,
                              placeholder: (context, url) => wallpaperShimmer(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )),
                      const Text("Tiny",style: TextStyle(
                          color: AppColor.black,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Fontmirror"),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
                      width: 2,
                      color: Color(int.parse("0xff$ageColor")))),
                  child: Column(
                    children: [
                      GridTile(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                            child: CachedNetworkImage(
                              memCacheHeight: 1024,
                              memCacheWidth: 1024,
                              imageUrl: widget.wallpaperModel.src.original,
                              placeholder: (context, url) => wallpaperShimmer(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )),
                      const Text("Original",style: TextStyle(
                          color: AppColor.black,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Fontmirror"),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
                      width: 2,
                      color: Color(int.parse("0xff$ageColor")))),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: [
                          GridTile(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                                child: CachedNetworkImage(
                                  memCacheHeight: 1024,
                                  memCacheWidth: 1024,
                                  imageUrl: widget.wallpaperModel.src.portrait,
                                  placeholder: (context, url) => wallpaperShimmer(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              )),
                          const Text("Portrait",style: TextStyle(
                              color: AppColor.black,
                              fontStyle: FontStyle.italic,
                              fontFamily: "Fontmirror"),),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
                      width: 2,
                      color: Color(int.parse("0xff$ageColor")))),
                  child: Column(
                    children: [
                      GridTile(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                            child: CachedNetworkImage(
                              memCacheHeight: 1024,
                              memCacheWidth: 1024,
                              imageUrl: widget.wallpaperModel.src.landscape,
                              placeholder: (context, url) => wallpaperShimmer(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )),
                      const Text("Landscape",style: TextStyle(
                          color: AppColor.black,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Fontmirror"),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
                      width: 2,
                      color: Color(int.parse("0xff$ageColor")))),
                  child: Column(
                    children: [
                      GridTile(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                            child: CachedNetworkImage(
                              memCacheHeight: 1024,
                              memCacheWidth: 1024,
                              imageUrl: widget.wallpaperModel.src.large,
                              placeholder: (context, url) => wallpaperShimmer(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )),
                      const Text("Large",style: TextStyle(
                          color: AppColor.black,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Fontmirror"),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
                      width: 2,
                      color: Color(int.parse("0xff$ageColor")))),
                  child: Column(
                    children: [
                      GridTile(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                            child: CachedNetworkImage(
                              memCacheHeight: 1024,
                              memCacheWidth: 1024,
                              imageUrl: widget.wallpaperModel.src.large2X,
                              placeholder: (context, url) => wallpaperShimmer(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )),
                      const Text("Large2X",style: TextStyle(
                          color: AppColor.black,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Fontmirror"),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
