import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper_hub1/utils/images.dart';
import 'package:wallpaper_hub1/widgets/videoPlayerFullScreenWidget.dart';

class VideoPlayerList extends StatefulWidget {
  String videoUrl;
  VideoPlayerList({Key? key,required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerList> createState() => _VideoPlayerListState();
}

class _VideoPlayerListState extends State<VideoPlayerList> {

  VideoPlayerController? _controller;

  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( body: VideoPlayerFullScreenWidget(controller: _controller!));

  }
}
