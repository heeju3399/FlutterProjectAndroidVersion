import 'package:flutter/material.dart';

class MainContentWidgetModel {
  static Color tileColor = Colors.white12;
  static Color textColor = Colors.white;
  static Color iconColor = Colors.white60;
  static Color backgroundColor = Colors.white12;
  static double basicFontSize = 25.0;
  static Text myText(String value){
    return Text(value, style: TextStyle(color: MainContentWidgetModel.textColor));
  }

}
