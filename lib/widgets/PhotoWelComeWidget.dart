import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub1/Model/welcomeModel.dart';
import 'package:wallpaper_hub1/utils/colors.dart';

class PhotoWelcomeWidget extends StatefulWidget {
  final int startIndex;

  const PhotoWelcomeWidget({Key? key, required this.startIndex}) : super(key: key);

  @override
  State<PhotoWelcomeWidget> createState() => _PhotoWelcomeWidgetState();
}

class _PhotoWelcomeWidgetState extends State<PhotoWelcomeWidget> {

  final ScrollController _scrollController=ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if(!_scrollController.position.atEdge){
        //implement scroll of list
        _autoScroll();
      }
      //adding to List
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _autoScroll();
      });
    });
  }

  void _autoScroll(){
    final currentScrollPosition=_scrollController.offset;
    final scrollEndPosition=_scrollController.position.maxScrollExtent;

    scheduleMicrotask(() {
      _scrollController.animateTo(currentScrollPosition == scrollEndPosition ? 0 :scrollEndPosition, duration: const Duration(seconds: 10), curve: Curves.linear);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 1.96 * pi,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        height  : MediaQuery.of(context).size.height * 0.60,
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context,index){
            return Container(
              margin: const EdgeInsets.only(right: 8,left: 8,top: 10),
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColor.black),
                  image: DecorationImage(
                      image: AssetImage(photoWelcome[widget.startIndex + index].photoImageUrl),fit: BoxFit.cover
                  )
              ),
            );
          },itemCount: 5,),
      ),
    );
  }
}
