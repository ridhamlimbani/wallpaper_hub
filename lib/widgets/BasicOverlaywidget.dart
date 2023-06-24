import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () =>
    controller.value.isPlaying ? controller.pause() : controller.play(),
  );

  Widget buildIndicator() => VideoProgressIndicator(
    controller,
    allowScrubbing: true,
  );

  Widget buildPlay() => controller.value.isPlaying
      ?  Container(
    alignment: Alignment.center,
    color: Colors.black26,
    child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
  )
      : Container(
    alignment: Alignment.center,
    color: Colors.black26,
    child: Icon(Icons.pause, color: Colors.white, size: 80),
  );
}