//
//
//
//
//
//
// import '../../Constants/ApiService.dart';
// import '../../Core/Tokens/AuthStorage.dart';
// import 'LoginModal.dart';
//
// class AuthRepository {
//   static Future<LoginResponse> login(LoginRequest request) async {
//     final res = await ApiService.post(
//       '/auth/login',
//       request.toJson(),
//     );
//
//     // save session
//     await AuthStorage.saveLoginData(
//       accessToken: res['token'],
//       refreshToken: res['refreshToken'],
//       expireTime: res['expireTime'],
//       userData: res['user'],
//     );
//
//     return LoginResponse.fromJson(res);
//   }
// }
