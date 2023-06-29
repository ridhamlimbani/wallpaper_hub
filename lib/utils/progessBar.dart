import 'package:flutter/material.dart';

class ProgressBar {


  ProgressBar();

  static bool isShowing = false;


  show(BuildContext context) {
    isShowing = true;
    return showDialog(
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          content: Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const[
                SizedBox(width: 24, height: 24, child:  CircularProgressIndicator(strokeWidth: 2)),
              ],
            ),
          ),
        ),
        onWillPop: () async => false,
      ), context: context,
    );
  }

  hide(BuildContext context) {
    if (isShowing) {
      isShowing = false;
      Navigator.of(context).pop();
    }
  }
}