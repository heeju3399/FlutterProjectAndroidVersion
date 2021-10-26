import 'package:android/page/mobileDash/content/mobileWriteContentPage.dart';
import 'package:android/page/mobileDash/mobildMainBody.dart';
import 'package:android/page/user/mobileLogIn.dart';
import 'package:android/page/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/myWord.dart';



class TestDash extends StatefulWidget {
  const TestDash({Key key}) : super(key: key);

  @override
  _MainDashState createState() => _MainDashState();
}

class _MainDashState extends State<TestDash> {
  String userId = '';
  Map getTextFiledMap = {MyWord.GET_TEXT_FILED_MAP: MyWord.EMPTY};
  bool firstCheck = true;
  bool reloadCheck = true;
  DateTime currentBackPressTime;

  void reload() async {
    setState(() {
      reloadCheck = false;
    });
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      reloadCheck = true;
    });
  }

  set setChartPageValue(Map map) {
    getTextFiledString(map);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getTextFiledString(Map map) async {
    bool mapIsEmpty = map.isNotEmpty;
    if (mapIsEmpty) {
      var firstKey = map.keys.first;
      String value = map.values.join(firstKey);
      print(value);
      getTextFiledMap = {MyWord.GET_TEXT_FILED_MAP: value};
      setState(() {});
    }
  }

  void mobileWriteContent(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MobileWriteContentMain(
              userId: userId,
            )));
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: onWillPop, child: isMobileScaffold(context));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: '종료 하시려면 한번더 터치해주세요');
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget isMobileScaffold(BuildContext context) {
    bool checkLogin = true;
    if (userId == MyWord.LOGIN) {
      checkLogin = true;
    }
    return Scaffold(
        appBar: AppBar(title: Text(MyWord.TEST_SITE), backgroundColor: Colors.white12, actions: [
          if (userId == MyWord.LOGIN)
            IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MobileLogin(userId: userId)));
                }),
          if (userId != MyWord.LOGIN)
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProFile(userId: userId)));
                },
                child: Text('$userId'))
        ]),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Container(
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
          //MobileMainHead(),
          Divider(height: 5, color: Colors.white12, indent: 0),
          reloadCheck ? MobileMainBody(userId: userId) : Padding(padding: const EdgeInsets.only(top: 200), child: Center(child: CircularProgressIndicator()))
        ]))),
        floatingActionButton: checkLogin
            ? null
            : FloatingActionButton(
                onPressed: () {
                  //mobileWriteContent(context);
                },
                child: Icon(Icons.add)));
  }
}
