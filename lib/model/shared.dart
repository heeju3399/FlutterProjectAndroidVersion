import 'package:android/model/myWord.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShared {
  String userId;

  void setUserId(String userId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString(MyWord.USERID, userId);
  }

  Future<String> getUserId() async {
    String result = '';
    userId = MyWord.LOGIN;
    SharedPreferences sh = await SharedPreferences.getInstance();
    if (sh.containsKey(MyWord.USERID)) {
      if (sh.getString(MyWord.USERID).toString() != '' && sh.getString(MyWord.USERID).toString().isNotEmpty) {
        userId = sh.getString(MyWord.USERID).toString();
        result = userId;
      }
    }
    return result;
  }
}
