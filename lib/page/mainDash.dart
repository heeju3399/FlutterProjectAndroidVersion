import 'package:android/model/myWord.dart';
import 'package:android/model/shared.dart';
import 'package:android/page/mobileDash/content/mobileWriteContentPage.dart';
import 'package:android/page/mobileDash/mobildMainBody.dart';
import 'package:android/page/mobileDash/mobileMainHead.dart';
import 'package:android/page/user/mobileLogIn.dart';
import 'package:android/page/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainDash extends StatefulWidget {
  const MainDash({Key key}) : super(key: key);

  static _MainDashState of(BuildContext context) => context.findAncestorStateOfType<_MainDashState>();

  @override
  _MainDashState createState() => _MainDashState();
}

class _MainDashState extends State<MainDash> {
  MyShared myShared = MyShared();
  Map getTextFiledMap = {MyWord.GET_TEXT_FILED_MAP: MyWord.EMPTY};
  bool firstCheck = true;
  bool reloadCheck = true;
  DateTime currentBackPressTime;
  String userId = 'LogIn';

  set setBool(bool check) {
    reload();
  }

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
              userId: myShared.userId,
            )));
    reload();
  }

  @override
  void dispose() {
    myShared.setUserId(MyWord.LOGIN);
    print('main dispose pass');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myShared.getUserId();
  }

  @override
  Widget build(BuildContext context) {
    String userId = myShared.userId.toString();
    print('main Dash call userid : $userId');
    return WillPopScope(onWillPop: onWillPop, child: isMobileScaffold(context, userId));
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
  Future<void> onRefresh2 () async {
    print('pass');
    reload();

  }

  Widget isMobileScaffold(BuildContext context, String userId) {
    bool checkLogin = false;
    print('???? : $userId');
    if (userId == MyWord.LOGIN) {
      checkLogin = true;
    }
    print('?? : $checkLogin');
    return Scaffold(
        appBar: AppBar(title: Text(MyWord.TEST_SITE), backgroundColor: Colors.white12, actions: [
          if (userId == MyWord.LOGIN)
            IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  callNavigator(0, userId);
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MobileLogin(userId: userId)));
                }),
          if (userId != MyWord.LOGIN)
            TextButton(
                onPressed: () {
                  callNavigator(1, userId);
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProFile(userId: userId)));
                },
                child: Text(userId))
        ]),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: RefreshIndicator(
            color: Colors.white12,
            backgroundColor: Colors.white12,
            onRefresh: () => onRefresh2(),
            child: SingleChildScrollView(
                child: Container(
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
              MobileMainHead(),
              Divider(height: 5, color: Colors.white12, indent: 0),
              reloadCheck
                  ? MobileMainBody(userId: userId)
                  //Container()
                  :
              Padding(padding: const EdgeInsets.only(top: 200), child: Center(child: CircularProgressIndicator()))
            ]))),
          ),
        ),
        floatingActionButton: checkLogin
            ? null
            : FloatingActionButton(
                onPressed: () {
                  mobileWriteContent(context);
                },
                child: Icon(Icons.add)));
  }

  void callNavigator(int flag, String userId) async {
    if (flag == 0) {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => MobileLogin(userId: userId)));
    } else if (flag == 1) {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProFile(userId: userId)));
    }else{

    }
    myShared.getUserId();
    userId = myShared.userId;
    reload();
    setState(() {});
  }
}
