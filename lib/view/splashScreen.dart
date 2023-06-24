import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/images.dart';
import 'package:wallpaper_hub1/view/WelComeScreen/PhotoWelcomeScreen.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PhotoWelComeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Wallpaper",
                    style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: "Fontmirror"),
                  ),
                  TextSpan(
                    text: "Hub",
                    style: TextStyle(
                        color: AppColor.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: "Fontmirror"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Lottie.asset(AppLottie.loading, height: 70),
        ],
      ),
    );
  }
}
