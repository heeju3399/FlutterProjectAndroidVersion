import 'dart:convert';
import 'dart:ui';
import 'package:android/control/content.dart';
import 'package:android/model/content.dart';
import 'package:android/model/mainContentTileColor.dart';
import 'package:android/model/myWord.dart';
import 'package:android/page/dialog/dialog.dart';
import 'package:android/page/mainDash.dart';
import 'package:android/page/mobileDash/content/mobileCommentPage.dart';
import 'package:android/page/mobileDash/mobildMainBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MobileAllContentPage extends StatefulWidget {
  const MobileAllContentPage({Key key, this.data, this.userId}) : super(key: key);
  final List<MainContentDataModel> data;
  final String userId;

  @override
  _MobileAllContentPageState createState() => _MobileAllContentPageState(data: data, userId: userId);
}

class _MobileAllContentPageState extends State<MobileAllContentPage> {
  _MobileAllContentPageState({this.data, this.userId});

  final List<MainContentDataModel> data;
  final String userId;
  List<Widget> widgetList = [];
  List<TextEditingController> textEditingController = [];
  List<bool> favoriteOnHover = [];
  List<bool> badOnHover = [];
  List<int> valueList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  String exString1 = '';
  Map returnMap = Map();
  Map mapEx1 = Map();
  String utf8StringContent = '';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        MainContentDataModel item = data[index];
        return _mainBuild(item, index, context);
      },
      itemCount: data.length,
      shrinkWrap: true,
    );
  }

  Widget _mainBuild(MainContentDataModel item, int index, BuildContext context) {
    List<dynamic> utf8List = jsonDecode(item.content);
    List<int> intList = [];
    utf8List.forEach((element) {
      intList.add(element);
    });
    utf8StringContent = utf8.decode(intList).toString();
    textEditingController.add(TextEditingController());
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ExpansionTile(
          collapsedBackgroundColor: MainContentWidgetModel.backgroundColor,
          backgroundColor: Colors.black12,
          trailing: Icon(Icons.comment, size: 15, color: MainContentWidgetModel.iconColor),
          title: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Text('$utf8StringContent',
                        maxLines: 5, overflow: TextOverflow.clip, style: TextStyle(color: MainContentWidgetModel.textColor, fontSize: 15)))
              ])),
          subtitle: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(Icons.favorite, size: 15, color: MainContentWidgetModel.iconColor),
                  Text('  ( ${item.likeCount} )', style: TextStyle(color: MainContentWidgetModel.textColor, fontSize: 12)),
                  Padding(padding: const EdgeInsets.only(left: 5), child: Icon(Icons.mood_bad, size: 15, color: MainContentWidgetModel.iconColor)),
                  Text('  ( ${item.badCount} )', style: TextStyle(color: MainContentWidgetModel.textColor, fontSize: 12)),
                  Padding(padding: const EdgeInsets.only(left: 5), child: Icon(Icons.comment, size: 15, color: MainContentWidgetModel.iconColor)),
                  Text('  ( ${item.children.length} )', style: TextStyle(color: MainContentWidgetModel.textColor, fontSize: 12)),
                  Padding(padding: const EdgeInsets.only(left: 5), child: likeAndBadIcon(0, item, index)),
                  Padding(padding: const EdgeInsets.only(left: 5), child: likeAndBadIcon(1, item, index))
                ]),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Divider(),
                      Padding(padding: const EdgeInsets.only(left: 15), child: Text(item.userId, style: TextStyle(color: Colors.white))),
                      Padding(padding: const EdgeInsets.only(left: 15), child: MainContentWidgetModel.myText(item.createTime))
                    ]))
              ])),
          onExpansionChanged: (v) {
            if (v) {
              int id = item.contentId;
              String sId = id.toString();
              Map sortToMap = {sId: 1};
              for (int i = 0; i < sortToMap.length; i++) {
                exString1 = sortToMap.keys.elementAt(i);
                valueList[index] = sortToMap.values.elementAt(i) + valueList[index];
                mapEx1 = {exString1: valueList[index]};
                returnMap.addAll(mapEx1);
              }
              setState(() {});
            }
          },
          children: tenComment(item, index, context)),
    );
  }

  Widget likeAndBadIcon(int flag, MainContentDataModel item, int index) {
    favoriteOnHover.add(false);
    badOnHover.add(false);
    int contentId = item.contentId;
    return InkWell(
        onTap: () {
          MainContentControl.setLikeAndBad(contentId: contentId, flag: flag);
          MainDash.of(context).setBool = false;
        },
        onHover: (v) {
          if (flag == 0 && v) {
            setState(() {
              favoriteOnHover[index] = true;
            });
          } else if (flag == 1 && v) {
            print('1 pass $v');
            setState(() {
              badOnHover[index] = true;
            });
          } else {
            setState(() {
              favoriteOnHover[index] = false;
              badOnHover[index] = false;
            });
          }
        },
        child: Container(
          width: 40,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            if (flag == 0) Icon(Icons.favorite, size: 20, color: favoriteOnHover[index] ? Colors.red : MainContentWidgetModel.iconColor),
            if (flag == 1) Icon(Icons.mood_bad, size: 20, color: badOnHover[index] ? Colors.blue : MainContentWidgetModel.iconColor),
          ]),
        ));
  }

  List<Widget> tenComment(MainContentDataModel item, int index, BuildContext context) {
    int itemChildrenLength = item.children.length;
    widgetList = [inputComment(item, index, context)];
    for (int i = 0; i < 10; i++) {
      if (i < itemChildrenLength) {
        try {
          MainCommentDataModel mainCommentDataModel = MainCommentDataModel.fromJson(item.children[i]);
          widgetList.add(commentList(mainCommentDataModel, item, i));
        } catch (e) {}
      }
    }
    if (10 < itemChildrenLength) {
      widgetList.add(lastClickPage(index, item, context));
    }
    widgetList.add(Divider(color: Colors.white, height: 50));
    return widgetList;
  }

  Widget lastClickPage(int index, MainContentDataModel item, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 300,
            height: 30,
            child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
                child: Text('덧글 전체보기'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MobileCommentPage(content: item)));
                })));
  }

  Widget inputComment(MainContentDataModel item, int index, BuildContext context) {
    //print('input comment pass');
    return Container(
        width: 400,
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
                controller: textEditingController[index],
                autofocus: true,
                onSubmitted: (v) {
                  if (v != '' && v.isNotEmpty) {
                    if (userId != MyWord.LOGIN) {
                      MainContentControl.setComment(index: index, item: item, value: v, userId: userId, context: context);
                      MainDash.of(context).setBool = false;
                      textEditingController[index].clear();
                    } else {
                      textEditingController[index].clear();
                      MyDialog.setContentDialog(title: '접속불가', message: '로그인 부탁드려요', context: context);
                    }
                  }
                },
                style: TextStyle(fontSize: 15, color: Colors.white),
                decoration: const InputDecoration(
                    labelText: '댓 글',
                    hintText: '입력 후 엔터',
                    hintStyle: TextStyle(fontSize: 10, color: Colors.white),
                    labelStyle: TextStyle(fontSize: 10, color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1.0)), borderSide: BorderSide(width: 1, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1.0)), borderSide: BorderSide(width: 1, color: Colors.white)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.0)))))));
  }

  Widget commentList(MainCommentDataModel comment, MainContentDataModel item, int order) {
    List<dynamic> utf8List = jsonDecode(comment.comment);
    List<int> intList = [];
    utf8List.forEach((element) {
      intList.add(element);
    });
    String decodeComment = utf8.decode(intList).toString();
    bool myIdCheck = false;
    if (comment.userId == userId) {
      myIdCheck = true;
    }
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            hoverColor: Colors.black12,
            selectedTileColor: MainContentWidgetModel.tileColor,
            tileColor: MainContentWidgetModel.tileColor,
            title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                      child: Text(decodeComment,
                          style: TextStyle(color: MainContentWidgetModel.textColor, fontSize: 15), maxLines: 5, overflow: TextOverflow.clip)),
                  myIdCheck
                      ? IconButton(
                          icon: Icon(Icons.delete_forever, color: MainContentWidgetModel.iconColor, size: 15),
                          onPressed: () {
                            MainContentControl.deleteComment(contentId: item.contentId, userId: userId, order: order);
                            MainDash.of(context).setBool = false;
                          })
                      : Container(child: Text(comment.userId, style: TextStyle(color: Colors.white, fontSize: 15)))
                ]))));
  }
}
