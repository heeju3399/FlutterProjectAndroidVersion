class SignupRequest {
  final String title;
  final String message;
  final String name;
  final int stateCode;

  SignupRequest({  this.title,  this.message,  this.stateCode,  this.name});
}

class SignupResponse {
  final String title;
  final String message;
  final int stateCode;

  SignupResponse({  this.title,  this.message,  this.stateCode});

  factory SignupResponse.fromJson(Map<dynamic,dynamic> json) {
    return SignupResponse(
      title: json['title'],
      message: json['message'],
      stateCode: json['stateCode'],
    );
  }
}
