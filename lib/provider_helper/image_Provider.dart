import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;

import 'package:wallpaper_hub1/utils/colors.dart';

class ImageInfoProvider extends ChangeNotifier{

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


}