class Login {
  final String id;
  final String pass;
  Login({ this.id,  this.pass});
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      id: json['id'],
      pass: json['title'],
    );
  }
}

class LogInResponse {
  final String title;
  final String message;
  final int stateCode;

  LogInResponse({  this.title,  this.message,  this.stateCode});

  factory LogInResponse.fromJson(Map<dynamic,dynamic> json) {
    return LogInResponse(
      title: json['title'],
      message: json['message'],
      stateCode: json['stateCode'],
    );
  }
}
