class MainContentDataModel {
  const MainContentDataModel(
      { this.contentId,
        this.createTime,
        this.userId,
        this.visible,
        this.children,
        this.content,
        this.badCount,
        this.likeCount,
        this.viewCount});

  final int contentId;
  final String content;
  final int likeCount;
  final int badCount;
  final int viewCount;
  final String userId;
  final String createTime;
  final String visible;
  final List<dynamic> children;

  factory MainContentDataModel.fromJson(Map<dynamic, dynamic> json) {
    return MainContentDataModel(
      contentId: json['contentid'],
      content: json['content'],
      userId: json['userid'],
      createTime: json['createtime'],
      visible: json['visible'],
      badCount: json['bad'],
      children: json['comment'],
      likeCount: json['like'],
      viewCount: json['view'],
    );
  }
}

class MainCommentDataModel {
  const MainCommentDataModel({ this.comment,  this.visible,  this.userId,  this.createTime});

  final String comment;
  final String visible;
  final String userId;
  final String createTime;

  factory MainCommentDataModel.fromJson(Map<dynamic, dynamic> json) {
    return MainCommentDataModel(
      visible: json['visible'],
      createTime: json['createtime'],
      userId: json['userid'],
      comment: json['content'],
    );
  }
}

class ResponseContent {
  const ResponseContent({ this.mainDashContent});
  final List<dynamic> mainDashContent;


  factory ResponseContent.fromJson(Map<dynamic, dynamic> json) {
    return ResponseContent(mainDashContent: json['maindashcontent']);
  }
}

class ResponseUserContent {
  const ResponseUserContent({ this.mainDashContent});
  final List<dynamic> mainDashContent;


  factory ResponseUserContent.fromJson(Map<dynamic, dynamic> json) {
    return ResponseUserContent(mainDashContent: json['maindashcontent']);
  }
}
