import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
          debugPrint("➡️ ${options.method} ${options.uri}");

          // 🔥 TOKEN ADD KARO (App API ke liye)
          if (type == ApiType.app) {
            String? token = await LocalStorage.getToken(); // ⬅️ Yeh implement karo

            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token'; // ⬅️ YEH LINE ADD KARO
            }
          }

          debugPrint("➡️ HEADERS: ${options.headers}");
          debugPrint("➡️ BODY: ${options.data}");
          return handler.next(options);
        },

        // Optional: Error handling
        onError: (DioException error, handler) async {
          debugPrint("❌ Error: ${error.response?.statusCode}");
          debugPrint("❌ Error Data: ${error.response?.data}");

          // Agar 401 (Unauthorized) aaye, toh logout karo
          if (error.response?.statusCode == 401) {
            await LocalStorage.clear();
            // Navigate to login screen
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> post(
      String path,
      dynamic data, {
        Map<String, String>? headers,
      }) {
    return _dio.post(
      path,
      data: data,
      options: Options(
        headers: {
          ..._dio.options.headers,
          if (headers != null) ...headers,
        },
      ),
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