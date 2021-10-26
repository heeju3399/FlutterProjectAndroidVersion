
import 'package:android/control/content.dart';
import 'package:android/page/dialog/dialog.dart';
import 'package:flutter/material.dart';

class MobileWriteContentMain extends StatefulWidget {
  const MobileWriteContentMain({Key key, this.userId}) : super(key: key);
  static String routeName = '/WriteContentMain';
  final String userId;

  @override
  _MobileWriteContentMainState createState() => _MobileWriteContentMainState(userId: userId);
}

class _MobileWriteContentMainState extends State<MobileWriteContentMain> {
  _MobileWriteContentMainState({this.userId});

  TextEditingController textFiledContentController = TextEditingController();
  final String userId;
  bool overClick = true;
  bool logInCircle = true;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

  //   return Container(
  //       child: Padding(padding: EdgeInsets.only(top: statusBarHeight))
  //   );
  // }
    return Scaffold(
        // appBar: AppBar(
        //    title: Text('글쓰기'),
        //   backgroundColor: Colors.white12,
        //   leading: Text('data'),
        //   //centerTitle: true,
        //
        //   titleSpacing: 10.0,
        //   automaticallyImplyLeading: false,
        //
        // ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: SingleChildScrollView(
              child: Center(
                  child: Container(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$userId 님의 글', maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(fontSize: 20, color: Colors.white))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    maxLines: 5,
                    textInputAction: TextInputAction.go,
                    autofocus: true,
                    onSubmitted: (v) {
                      setContext(context);
                    },
                    controller: textFiledContentController,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: '글쓰기',
                        labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide(width: 1, color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide(width: 1, color: Colors.white)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))))),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                    onTap: () {
                      setContext(context);
                    },
                    child: Container(
                        width: 200,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: logInCircle
                            ? Text('글쓰기', style: TextStyle(color: Colors.white))
                            : CircularProgressIndicator(backgroundColor: Colors.white))))
          ])))),
        ));
  }

  void setContext(BuildContext context) async {
    if (overClick) {
      setState(() {
        logInCircle = !logInCircle;
      });
      overClick = false;

      await MainContentControl.setContent(content: textFiledContentController.text, userId: userId).then((map) {
        print('map : $map');
        if (map.isNotEmpty) {
          if (map.values.first == 'pass') {
            Navigator.of(context).pop();
          } else {
            MyDialog.setContentDialog(title: '${map.values.first}', message: '${map.values.last}', context: context);
          }
          setState(() {
            logInCircle = !logInCircle;
          });
        }
        overClick = true;
      });
    }
  }
}
