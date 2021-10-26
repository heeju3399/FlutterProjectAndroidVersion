import 'package:android/model/myWord.dart';
import 'package:android/model/shared.dart';
import 'package:android/page/mainDash.dart';
import 'package:android/testDash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
       statusBarColor: Colors.white, // 투명색
     ));
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: MyWord.TEST_SITE,
      home: MainDash(),
    );
  }
}
