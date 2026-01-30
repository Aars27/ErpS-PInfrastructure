import 'package:dio/dio.dart';
import '../Core/Storage/local_storage.dart';
import '../Constants/ApiConstants.dart';

enum ApiType { auth, app }

class ApiService {
  late Dio _dio;

  ApiService({ApiType type = ApiType.app}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: type == ApiType.auth
            ? ApiConstants.authBaseUrl
            : ApiConstants.appBaseUrl,
        headers: ApiConstants.headers,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await LocalStorage.getToken();

          if (token != null && type == ApiType.app) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }

  ///  UPDATED POST (NOW SUPPORTS HEADERS)
  Future<Response> post(
      String path,
      Map data, {
        Map<String, String>? headers,
      }) {
    return _dio.post(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }

  Future<Response> get(
      String path, {
        Map<String, String>? headers,
      }) {
    return _dio.get(
      path,
      options: Options(headers: headers),
    );
  }
}
