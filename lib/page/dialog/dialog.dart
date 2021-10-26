import 'package:flutter/material.dart';

class MyDialog {
  static void setContentDialog({ String title,  String message,  BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              elevation: 20,
              shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.blueAccent), borderRadius: BorderRadius.circular(30)),
              title: Text("$title"),
              content: Text("$message"));
        });
  }
}
