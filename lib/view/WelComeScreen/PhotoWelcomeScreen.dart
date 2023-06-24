import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/images.dart';
import 'package:wallpaper_hub1/view/Image/homeScreen.dart';
import 'package:wallpaper_hub1/widgets/PhotoWelComeWidget.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';

class PhotoWelComeScreen extends StatefulWidget {
  const PhotoWelComeScreen({Key? key}) : super(key: key);

  @override
  State<PhotoWelComeScreen> createState() => _PhotoWelComeScreenState();
}

class _PhotoWelComeScreenState extends State<PhotoWelComeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          //Image transition
          Positioned(
              top: -10,
              left: -150,
              child: Row(
                children: const [
                  PhotoWelcomeWidget(
                    startIndex: 0,
                  ),
                  PhotoWelcomeWidget(
                    startIndex: 1,
                  ),
                  PhotoWelcomeWidget(
                    startIndex: 2,
                  ),
                ],
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.60,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.white60,
                  Colors.white,
                  Colors.white,
                ], begin: Alignment.topCenter, end: Alignment.center)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      brandName(),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(
                            color: AppColor.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          isRepeatingAnimation: true,
                          animatedTexts: [
                            TyperAnimatedText('Welcome To Photo Wallpaper'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
