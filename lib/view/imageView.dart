import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({Key? key,required this.imgUrl}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CachedNetworkImage(
                memCacheHeight: 1024,
                memCacheWidth: 1024,
                imageUrl:
                widget.imgUrl,
                placeholder:
                    (context, url) =>
                    wallpaperShimmer(),
                errorWidget: (context, url,
                    error) =>
                const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
