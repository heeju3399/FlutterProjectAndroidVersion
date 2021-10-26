import 'dart:convert';
import "dart:convert" show utf8;
import 'package:android/model/content.dart';
import 'package:android/model/login.dart';
import 'package:android/model/signUp.dart';
import 'package:http/http.dart' as http;

class NodeServer {
  static Future<bool> userDelete({String userId}) async {
    String flag = 'userDelete';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    bool returnResult = false;
    Map<String, String> map = Map();
    map = {"siteKey": '$siteKey', "flag": '$flag', "id": '$userId'};
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/userdelete'), headers: map);
      int stateCode = response.statusCode;
      if (stateCode == 200) {
        Map responseValue = jsonDecode(response.body);
        if (responseValue.values.first.contains('pass')) {
          returnResult = true;
        } else if (responseValue.values.first.contains('no')) {
          returnResult = false;
        }
      }
    } catch (e) {
      print('deleteComment error :$e');
      returnResult = false;
    }
    return returnResult;
  }

  static Future<bool> deleteComment({ int contentId,  String userId,  int order}) async {
    String flag = 'deleteComment';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    bool returnResult = false;
    Map<String, String> map = Map();
    map = {"siteKey": '$siteKey', "flag": '$flag', "contentid": '$contentId', "id": '$userId', "order": '$order'};
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/deletecomment'), headers: map);
      int stateCode = response.statusCode;
      print('$stateCode pass');
      if (stateCode == 200) {
        Map responseValue = jsonDecode(response.body);
        if (responseValue.values.first.contains('pass')) {
          returnResult = true;
        } else if (responseValue.values.first.contains('no')) {
          returnResult = false;
        }
      }
    } catch (e) {
      print('deleteComment error :$e');
      returnResult = false;
    }
    return returnResult;
  }

  static Future<bool> deleteContent(int contentId, String userId) async {
    String flag = 'deleteContent';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    bool returnResult = false;
    Map<String, String> map = Map();
    map = {"siteKey": '$siteKey', "flag": '$flag', "contentid": '$contentId', "id": '$userId'};
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/deletecontent'), headers: map);
      int stateCode = response.statusCode;
      print('$stateCode pass');
      if (stateCode == 200) {
        Map responseValue = jsonDecode(response.body);

        if (responseValue.values.first.contains('pass')) {
          returnResult = true;
        } else if (responseValue.values.first.contains('no')) {
          returnResult = false;
        }
      }
    } catch (e) {
      print('setComment error :$e');
      returnResult = false;
    }

    return returnResult;
  }

  static Future<bool> deleteAllContent(int contentId, String userId) async {
    String flag = 'deleteAllContent';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    bool returnResult = false;
    Map<String, String> map = Map();
    map = {"siteKey": '$siteKey', "flag": '$flag', "contentid": '$contentId', "id": '$userId'};
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/deleteallcontent'), headers: map);
      int stateCode = response.statusCode;
      print('$stateCode pass');
      if (stateCode == 200) {
        Map responseValue = jsonDecode(response.body);

        if (responseValue.values.first.contains('pass')) {
          returnResult = true;
        } else if (responseValue.values.first.contains('no')) {
          returnResult = false;
        }
      }
    } catch (e) {
      print('setComment error :$e');
      returnResult = false;
    }

    return returnResult;
  }

  static Future<List<dynamic>> getUserContents({ String userId}) async {
    String flag = 'getusercontent';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    Map<String, String> map = Map();
    List returnList = [];
    map = {"siteKey": '$siteKey', "flag": '$flag', "id": '$userId'};
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/getusercontent'), headers: map);
      int stateCode = response.statusCode;
      print('$stateCode pass');
      if (stateCode == 200) {
        Map<dynamic, dynamic> responsePassCheck = jsonDecode(response.body);
        if (responsePassCheck.values.elementAt(0).contains('pass')) {
          returnList.add('pass');
          String mainDashContent = responsePassCheck.values.elementAt(1).toString();
          returnList.add(jsonDecode(mainDashContent));
        }
      } else {
        returnList.add('no');
      }
    } catch (e) {
      print('getUserContents err : $e');
      returnList.add('err');
    }

    return returnList;
  }

  static Future<bool> setComment({MainCommentDataModel comment,  int contentId}) async {
    String flag = 'setcomment';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    bool returnResult = false;
    Map<String, String> map = Map();
    map = {
      "siteKey": '$siteKey',
      "id": '${comment.userId}',
      "comment": '${comment.comment}',
      "flag": '$flag',
      "nowtime": '${comment.createTime}',
      "visible": '${comment.visible}',
      "contentid": '$contentId'
    };
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/setcomment'), headers: map);
      int stateCode = response.statusCode;
      print('$stateCode pass');
      if (stateCode == 200) {
        String result = response.body.toString();
        print('body : $result');
        result = result.substring(10, 14);
        print('sub?? $result');
        if (result.contains('pass')) {
          returnResult = true;
        } else if (result.contains('no')) {
          returnResult = false;
        }
      }
    } catch (e) {
      print('setComment error :$e');
      returnResult = false;
    }
    return returnResult;
  }

  static Future<bool> setLikeAndBad({ int contentId,  int likeAndBad}) async {
    String flag = 'setlikeandbad';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    bool returnResult = false;
    Map<String, String> map = Map();
    map = {"siteKey": '$siteKey', "flag": '$flag', "likeandbad": '$likeAndBad', "contentid": '$contentId'};

    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/setlikeandbad'), headers: map);
      int stateCode = response.statusCode;
      if (stateCode == 200) {
        String result = response.body.toString();
        print('body : $result');
        result = result.substring(10, 14);
        print('sub?? $result');
        if (result.contains('pass')) {
          returnResult = true;
        } else if (result.contains('no')) {
          returnResult = false;
        }
      }
    } catch (e) {
      print(e);
      returnResult = false;
    }
    return returnResult;
  }

  void getLikeAndBad() async {}

  static Future<bool> setContents({ String content,  String userId}) async {
    String flag = 'setcontent';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    bool returnResult = false;
    String nowTime = DateTime.now().toString();
    String visible = '1';
    print('contetn : $content');
    var contentEncode = utf8.encode(content);
    Map<String, String> map = Map();
    map = {"siteKey": '$siteKey', "id": '$userId', "content": '$contentEncode', "flag": '$flag', "nowtime": '$nowTime', "visible": '$visible'};
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/setcontent'), headers: map);
      int stateCode = response.statusCode;
      print('$stateCode pass');
      if (stateCode == 200) {
        String result = response.body.toString();
        print('body : $result');
        result = result.substring(10, 14);
        print('sub?? $result');
        if (result.contains('pass')) {
          returnResult = true;
        } else if (result.contains('no')) {
          returnResult = false;
        }
      }
    } catch (e) {
      print('error :$e');
      returnResult = false;
    }
    return returnResult;
  }

  static Future<List<dynamic>> getAllContents() async {
    String flag = 'setcontent';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    Map<String, String> map = Map();
    List returnList = [];
    map = {"siteKey": '$siteKey', "flag": '$flag'};
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/getallcontent'), headers: map);
      int stateCode = response.statusCode;
      print('$stateCode pass');
      if (stateCode == 200) {
        Map<dynamic, dynamic> responsePassCheck = jsonDecode(response.body);
        if (responsePassCheck.values.elementAt(0).contains('pass')) {
          print('pass _ pass');
          returnList.add('pass');
          List<dynamic> mainDashContent = responsePassCheck.values.elementAt(1);
          returnList.add(mainDashContent);
        }
      } else {
        returnList.add('no');
      }
    } catch (e) {
      print('getAllContents err : $e');
      returnList.add('err');
    }
    return returnList;
  }

  static Future<LogInResponse> signIn(String id, String pass) async {
    String flag = 'signIn';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    var response;
    LogInResponse logInResult = LogInResponse(stateCode: 000, message: '서버 접속 불가', title: 'err');
    Map<String, String> map = Map();
    map = {"siteKey": '$siteKey', "id": '$id', "pass": '$pass', "flag": '$flag'};
    try {
      response = await http.post(Uri.parse('http://172.30.1.19:3000/login'), headers: map);
      int stateCode = response.statusCode;
      Map stateMap = Map();
      Map<dynamic, dynamic> returnMap = Map();
      var decode = jsonDecode(response.body);
      returnMap.addAll(decode);
      stateMap = {'stateCode': stateCode};
      returnMap.addAll(stateMap);
      logInResult = LogInResponse.fromJson(returnMap);
    } catch (e) {
      print('signIn err : $e');
    }
    return logInResult;
  }

  static Future<SignupResponse> signUp({ String id,  String pass,  String name}) async {
    String flag = 'signup';
    String siteKey = 'secretKey'; //실제 쓰일댄 이렇게 쓰면안됨 파이버 베이스 같은곳에 넣어서 쓰기
    Map<String, String> requestMap = Map();
    requestMap = {"siteKey": '$siteKey', "id": '$id', "pass": '$pass', "name": '$name', "flag": '$flag'};
    SignupResponse signUpResponse = SignupResponse(stateCode: 000, message: '서버 접속 불가', title: 'err');
    try {
      var response = await http.post(Uri.parse('http://172.30.1.19:3000/signup'), headers: requestMap);
      int stateCode = response.statusCode;
      Map returnMap = Map();
      Map<dynamic, dynamic> stateMap = Map();
      var decode = jsonDecode(response.body);
      stateMap.addAll(decode);
      returnMap = {'stateCode': stateCode};
      stateMap.addAll(returnMap);
      signUpResponse = SignupResponse.fromJson(stateMap);
    } catch (e) {
      print('signup err : $e');
    }
    return signUpResponse;
  }
}
