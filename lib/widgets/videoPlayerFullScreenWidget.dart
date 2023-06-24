import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/images.dart';
import 'package:wallpaper_hub1/widgets/BasicOverlaywidget.dart';

class VideoPlayerFullScreenWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerFullScreenWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Container(
              alignment: Alignment.topCenter,
              child: buildVideo(),
            )
          : const Center(
              child: CircularProgressIndicator(),
            );

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: [
          buildVideoPlayer(),
          BasicOverlayWidget(controller: controller)
        ],
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = controller.value.size;
    final width=size.width;
    final height=size.height;
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
          width: width,
          height: height,
          child: child),
    );
  }
}
