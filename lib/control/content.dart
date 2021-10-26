import 'dart:convert';
import 'package:android/model/content.dart';
import 'package:android/model/shared.dart';
import 'package:android/server/nodeServer.dart';
import 'package:flutter/cupertino.dart';

class MainContentControl {



  static Future<Map> setContent({ String content,  String userId}) async {
    Map resultMap = Map();
    bool result = false;
    if (content == '' || content.isEmpty) {
      resultMap = {'title': '빈칸을 채워주세요', 'message': '하고싶은 말을 적어주세요'};
    } else {
      await NodeServer.setContents(content: content, userId: userId).then((value) => {result = value});
      if (result) {
        resultMap = {'title': 'pass', 'message': ''};
      } else {
        resultMap = {'title': '에러', 'message': '관리자에게 문의 하세요'};
      }
    }
    return resultMap;
  }

  static Future<List<MainContentDataModel>> getUserContents({ String userId}) async {
    List response = [];
    List<MainContentDataModel> returnList = [];
    await NodeServer.getUserContents(userId: userId).then((value) => {response = value});
    try {
      if (response.first == 'pass') {
        response = response.last;
        response.forEach((element) {
          MainContentDataModel mainContentDataModel = MainContentDataModel.fromJson(jsonDecode(jsonEncode(element)));
          returnList.add(mainContentDataModel);
        });
      }
    } catch (e) {
      print('getUserContent-err($e)');
    }
    return returnList;
  }

  static Future<List<MainContentDataModel>> getContent2() async {
    List response = [];
    List<MainContentDataModel> returnList = [];
    await NodeServer.getAllContents().then((value) => {response = value});
    try {
      if (response.first == 'pass') {
        response = response.last;
        response.forEach((element) {
          MainContentDataModel mainContentDataModel = MainContentDataModel.fromJson(jsonDecode(jsonEncode(element)));
          returnList.add(mainContentDataModel);
        });
      }
    } catch (e) {
      print('getContent2 err ($e)');
    }
    //returnList = returnList.reversed.toList();
    return returnList;
  }

  static Future<bool> setComment({ String value,  int index,  MainContentDataModel item,  String userId,  BuildContext context}) async {
    bool result = false;
    var contentEncode = utf8.encode(value); //변환후 입력해야함
    MainCommentDataModel mainCommentDataModel = MainCommentDataModel(comment: '$contentEncode', userId: userId, createTime: '${DateTime.now()}', visible: '1');
    await NodeServer.setComment(comment: mainCommentDataModel, contentId: item.contentId).then((value) => {result = value});
    return result;
  }

  static void setLikeAndBad({ int flag,  int contentId}) {
    NodeServer.setLikeAndBad(contentId: contentId, likeAndBad: flag).then((value) => {});
  }

  static void deleteContent(int contentId, String userId) {
    NodeServer.deleteContent(contentId, userId);
  }

  static void deleteAllContent(int contentId, String userId) {
    NodeServer.deleteAllContent(contentId, userId);
  }

  static void deleteComment({ int contentId,  String userId,  int order}) async {
    NodeServer.deleteComment(order: order, userId: userId, contentId: contentId); //bool 타입으로 리턴되는데 뭐쓰지?
  }

  static Future<bool> userDelete({ String userId}) async {
    bool check = false;
    await NodeServer.userDelete(userId: userId).then((value) => {
      check = value
    });
    if(check){
      MyShared myShared = MyShared();
      myShared.setUserId('LogIn');
    }else{

    }
    return check;
  }
}