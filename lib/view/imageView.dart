import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/view/images/imageinfo.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';
import 'package:http/http.dart' as http;

class imageView extends StatefulWidget {
  final WallpaperModel wallpaperModel;

  const imageView({Key? key, required this.wallpaperModel}) : super(key: key);

  @override
  State<imageView> createState() => _imageViewState();
}

class _imageViewState extends State<imageView> with SingleTickerProviderStateMixin{

  late Stream<String> progressString;
  late String res;
  bool downloading = false;
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";


  var result = "Waiting to set wallpaper";
  bool _isDisable = true;

  int nextImageID = 0;

  Future<void> downloadAndSaveImage(String imageUrl, BuildContext context) async {
    final response = await http.get(Uri.parse(imageUrl));
    final fileBytes = response.bodyBytes;

    final tempDir = Directory.systemTemp;
    final tempPath = '${tempDir.path}/image.jpg';

    final file = File(tempPath);
    await file.writeAsBytes(fileBytes);

    await GallerySaver.saveImage(file.path, albumName: 'Wallpaper Hub');

    Fluttertoast.showToast(
      msg: 'Image downloaded in wallpaper Hub Folder',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: AppColor.mainColor,
      gravity: ToastGravity.BOTTOM,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Hero(
            tag: widget.wallpaperModel.src.portrait,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: PinchZoom(

                resetDuration: const Duration(milliseconds: 100),
                maxScale: 2.5,
                child:CachedNetworkImage(
                  memCacheHeight: 1024,
                  memCacheWidth: 1024,
                  imageUrl: widget.wallpaperModel.src.portrait,
                  placeholder: (context, url) => wallpaperShimmer(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.075,
              width: MediaQuery.of(context).size.width * 0.60,
              decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: AppColor.mainColor)),
              child: InkWell(
                onTap: (){
                  showModalBottomSheet(
                    isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                      ),
                      backgroundColor: AppColor.white,
                      context: context,
                      builder: (context) =>

                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setStateSheet){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 5,
                                width: 100,
                                decoration: BoxDecoration(color: AppColor.black,borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageInfoScreen(wallpaperModel: widget.wallpaperModel)));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(color: Colors.orangeAccent)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Image info",style: TextStyle(fontFamily: "Fontmirror",fontSize: 16,color: AppColor.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Downloading Image'),
                                        content: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children:const [
                                            CircularProgressIndicator(),
                                            SizedBox(width: 16.0),
                                            Text('Please wait...'),
                                          ],
                                        ),
                                      );
                                    },
                                  );

                                  downloadAndSaveImage(widget.wallpaperModel.src.portrait, context).then((_) {
                                    Navigator.pop(context); // Close the progress dialog
                                  });

                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  decoration: BoxDecoration(
                                      color: Colors.yellowAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(color: Colors.yellowAccent)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Download Image in Gallery",style: TextStyle(fontFamily: "Fontmirror",fontSize: 16,color: AppColor.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  progressString = Wallpaper.imageDownloadProgress(widget.wallpaperModel.src.portrait);
                                  progressString.listen((data) {
                                    setStateSheet(() {
                                      res = data;
                                      downloading = true;
                                    });
                                    print("DataReceived: " + data);
                                  }, onDone: () async {
                                    setStateSheet(() {
                                      downloading = false;

                                      _isDisable = false;
                                    });
                                    print("Task Done");
                                  }, onError: (error) {
                                    setStateSheet(() {
                                      downloading = false;
                                      _isDisable = true;
                                    });
                                    print("Some Error");
                                  });

                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  decoration: BoxDecoration(
                                      color: Colors.cyanAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(color: Colors.cyanAccent)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Download Image Set Wallpaper",style: TextStyle(fontFamily: "Fontmirror",fontSize: 16,color: AppColor.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap:_isDisable
                                    ? null
                                    : () async {
                                  print("Data List Model:- ${_isDisable}");
                                  var width = MediaQuery.of(context).size.width;
                                  var height = MediaQuery.of(context).size.height;
                                  home = await Wallpaper.homeScreen(
                                      options: RequestSizeOptions.RESIZE_FIT,
                                      width: width,
                                      height: height);
                                  setStateSheet(() {
                                    downloading = false;
                                    home = home;
                                  });
                                  print("Task Done");
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(color: Colors.deepPurpleAccent)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Set Wallpaper Home Screen",style: TextStyle(fontFamily: "Fontmirror",fontSize: 16,color: AppColor.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(color: Colors.greenAccent)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Set Wallpaper Lock Screen",style: TextStyle(fontFamily: "Fontmirror",fontSize: 16,color: AppColor.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(color: Colors.lightBlueAccent)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Set Wallpaper Both Screen",style: TextStyle(fontFamily: "Fontmirror",fontSize: 16,color: AppColor.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(color: Colors.lightGreenAccent)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Set Wallpaper System",style: TextStyle(fontFamily: "Fontmirror",fontSize: 16,color: AppColor.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      Text("Set Wallpaper",style: TextStyle(fontFamily: "Fontmirror",fontSize: 16,color: AppColor.white,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text("Image Download All Option",style: TextStyle(fontFamily: "Fontmirror",color: AppColor.white,fontStyle: FontStyle.italic,fontSize: 12),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
