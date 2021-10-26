import 'package:android/control/content.dart';
import 'package:android/model/content.dart';
import 'package:flutter/material.dart';
import 'content/mobileContentPage.dart';

class MobileMainBody extends StatefulWidget {
  const MobileMainBody({Key key,  this.userId}) : super(key: key);
  final String userId;

  static _MobileMainBodyState of(BuildContext context) => context.findAncestorStateOfType<_MobileMainBodyState>();

  @override
  _MobileMainBodyState createState() => _MobileMainBodyState();
}

class _MobileMainBodyState extends State<MobileMainBody> {
  bool reloadCheck = true;

  set setBool(bool check) {
    reload();
    print('reload method pass');
  }

  void reload() async {
    setState(() {
      reloadCheck = false;
    });
    await Future.delayed(Duration(milliseconds: 5));
    setState(() {
      reloadCheck = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Container(

                child: reloadCheck
                    ? FutureBuilder(
                        future: MainContentControl.getContent2(),
                        builder: (context, snap) {
                          if (!snap.hasData) {
                            return Center(child: Padding(padding: const EdgeInsets.all(18.0), child: CircularProgressIndicator()));
                          } else {
                            return MobileAllContentPage(data: snap.data as List<MainContentDataModel>, userId: widget.userId);
                          }
                        })
                    : LinearProgressIndicator())));
  }
}
