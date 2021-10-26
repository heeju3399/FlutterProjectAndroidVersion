import 'package:android/control/signUp.dart';
import 'package:android/page/mainDash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MobileSignUp extends StatefulWidget {
  const MobileSignUp({Key key}) : super(key: key);

  @override
  _MobileSignUpState createState() => _MobileSignUpState();
}

class _MobileSignUpState extends State<MobileSignUp> {
  Color btnColor = Colors.blueAccent;
  final textFiledIdController = TextEditingController();
  final textFiledPassController = TextEditingController();
  final textFiledNameController = TextEditingController();
  bool signUpCircle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Padding(padding: const EdgeInsets.all(18.0), child: Text('Test Site', textScaleFactor: 2, style: TextStyle(color: Colors.black))),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 300,
              child: TextField(
                  autofocus: true,
                  controller: textFiledIdController,
                  style: TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                      labelText: 'ID',
                      labelStyle: TextStyle(fontSize: 15),
                      suffixStyle: TextStyle(fontSize: 15),
                      hintStyle: TextStyle(fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide(width: 1, color: Colors.redAccent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide(width: 1, color: Colors.redAccent)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))))))),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 300,
              child: TextField(
                  controller: textFiledPassController,
                  style: TextStyle(fontSize: 15),
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'PASS',
                      labelStyle: TextStyle(fontSize: 15),
                      suffixStyle: TextStyle(fontSize: 15),
                      hintStyle: TextStyle(fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide(width: 1, color: Colors.redAccent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide(width: 1, color: Colors.redAccent)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))))))),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 300,
              child: TextField(
                  controller: textFiledNameController,
                  onSubmitted: (v) {
                    _signUpOperation(context);
                  },
                  style: TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 15),
                      suffixStyle: TextStyle(fontSize: 15),
                      hintStyle: TextStyle(fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide(width: 1, color: Colors.redAccent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide(width: 1, color: Colors.redAccent)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))))))),
      Padding(
          padding: const EdgeInsets.all(18.0),
          child: InkWell(
              onTap: () {
                _signUpOperation(context);
              },
              onHover: (isis) {
                if (isis) {
                  btnColor = Colors.green;
                } else {
                  btnColor = Colors.blue;
                }
                setState(() {});
              },
              child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: btnColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: signUpCircle
                      ? Text('회원가입', style: TextStyle(color: Colors.white))
                      : CircularProgressIndicator(backgroundColor: Colors.white)))),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: 120,
            height: 60,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('로그인', style: TextStyle(fontSize: 14, color: Colors.black)))),
        Container(
            width: 120, height: 60, child: TextButton(onPressed: () {}, child: Text('아이디찾기', style: TextStyle(fontSize: 14, color: Colors.black)))),
        Container(
            width: 120, height: 60, child: TextButton(onPressed: () {}, child: Text('비밀번호 찾기', style: TextStyle(fontSize: 14, color: Colors.black))))
      ]),
      Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(color: Colors.black, width: 120, height: 1),
            Text('간편회원가입', style: TextStyle(color: Colors.black, fontSize: 12)),
            Container(color: Colors.black, width: 120, height: 1)
          ]))),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              color: Colors.green,
              height: 50,
              width: 300,
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {},
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Spacer(flex: 1),
                    Padding(padding: const EdgeInsets.all(8.0), child: Image.asset('./assets/images/naver.ico')),
                    Spacer(flex: 5),
                    Text('네이버로 회원가입', style: TextStyle(color: Colors.white, fontSize: 15)),
                    Spacer(flex: 5)
                  ])))),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              color: Colors.yellow,
              height: 50,
              width: 300,
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {},
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Spacer(flex: 1),
                    Padding(padding: const EdgeInsets.all(8.0), child: Image.asset('./assets/images/kakao.png')),
                    Spacer(flex: 5),
                    Text('카카오로 회원가입', style: TextStyle(color: Colors.black, fontSize: 15)),
                    Spacer(flex: 5)
                  ])))),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              color: Colors.blue,
              height: 50,
              width: 300,
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {},
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Spacer(flex: 1),
                    Padding(padding: const EdgeInsets.all(8.0), child: Image.asset('./assets/images/google.png')),
                    Spacer(flex: 5),
                    Text('google로 회원가입', style: TextStyle(color: Colors.white, fontSize: 15)),
                    Spacer(flex: 5)
                  ])))),
      Padding(padding: const EdgeInsets.all(18.0), child: Text('Test Corporate', textScaleFactor: 1, style: TextStyle(color: Colors.black)))
    ])))));
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 20,
          shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.blueAccent), borderRadius: BorderRadius.circular(30)),
          title: new Text("$title"),
          content: new Text("$content"),
        );
      },
    );
  }

  bool overClick = true;
  String userid = '';

  void _signUpOperation(BuildContext context) async {
    if (overClick) {
      setState(() {
        signUpCircle = !signUpCircle;
      });
      overClick = false;
      userid = textFiledIdController.text;
      await SignUpController.checkIdAndPassAndName(
              pass: textFiledPassController.text, name: textFiledNameController.text, id: textFiledIdController.text)
          .then((map) {
        if (map.isNotEmpty) {
          if (map.values.first == 'pass') {
            textFiledIdController.clear();
            textFiledPassController.clear();
            textFiledNameController.clear();
            setState(() {
              signUpCircle = !signUpCircle;
            });
            Fluttertoast.showToast(msg: '회원 등록되었습니다.', backgroundColor: Colors.black, textColor: Colors.white);
            Navigator.of(context).pop();
          } else {
            _showDialog(map.values.first, map.values.last);
            setState(() {
              signUpCircle = !signUpCircle;
            });
          }
        }
        overClick = true;
      });
    }
  }
}
