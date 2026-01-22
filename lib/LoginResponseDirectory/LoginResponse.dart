import 'package:smp_erp/LoginResponseDirectory/User.dart';

class LoginResponse {
  final int status;
  final String message;
  final String token;
  final String refreshToken;
  final int expireTime;
  final User user;

  LoginResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.refreshToken,
    required this.expireTime,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      expireTime: json['expireTime'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'token': token,
      'refreshToken': refreshToken,
      'expireTime': expireTime,
      'user': user.toJson(),
    };
  }
}