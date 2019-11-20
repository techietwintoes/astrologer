import 'package:astrologer/core/data_model/user_model.dart';

const String UN_PROCESSABLE_ENTITY = "UNPROCESSABLE_ENTITY";
const String UN_AUTHORIZED = "UNAUTHORIZED";

class LoginResponse {
  String status;
  String error; // unused or not found in server response
  String message;
  String type;
  String token;
  bool firstLogin;
  String welcomeMessage;
  UserModel user;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        error = json['error'],
        type = json['type'],
        token = json['token'],
        firstLogin = json['firstLogin'],
        welcomeMessage = json['welcomeMessage'],
        user = UserModel.fromJson(json['userDetails']);

  LoginResponse(
      {this.status,
      this.error,
      this.type,
      this.token,
      this.firstLogin,
      this.welcomeMessage,
      this.user});

  LoginResponse fromJson(Map<String, dynamic> json) {
    if (status == UN_PROCESSABLE_ENTITY || status == UN_AUTHORIZED) {
      return LoginResponse.withError(message);
    }
    return LoginResponse(
      status: json['status'],
      error: json['error'],
      type: json['type'],
      token: json['token'],
      firstLogin: json['firstLogin'],
      welcomeMessage: json['welcomeMessage'],
      user: UserModel.fromJson(json['userDetails']),
    );
  }

  factory LoginResponse.withError(String error) => LoginResponse(error: error);
}