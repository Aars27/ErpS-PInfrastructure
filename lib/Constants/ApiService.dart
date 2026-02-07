import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Core/Storage/local_storage.dart';
import '../Constants/ApiConstants.dart';

enum ApiType { auth, app }

class ApiService {
  late Dio _dio;
  final ApiType type;

  ApiService({this.type = ApiType.app}) {
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
          debugPrint("🌐 ${options.method} ${options.uri}");
          debugPrint("🔍 Path: ${options.path}");

          // Add token for BOTH auth and app APIs (except login endpoint)
          if (!options.path.contains('/login')) {
            debugPrint("🔐 Attempting to fetch token from storage...");
            String? token = await LocalStorage.getToken();

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
              debugPrint("✅ Token added successfully");
              debugPrint("🔑 Token preview: Bearer ${token.substring(0, token.length > 20 ? 20 : token.length)}...");
            } else {
              debugPrint("❌ CRITICAL: No token found in storage or token is empty!");
              debugPrint("🔍 Token value: '$token'");
            }
          } else {
            debugPrint("⏭️ Skipping token for login endpoint");
          }

          debugPrint("➡️ FINAL HEADERS: ${options.headers}");
          debugPrint("➡️ BODY: ${options.data}");
          return handler.next(options);
        },

        onError: (DioException error, handler) async {
          debugPrint("❌ Error Status: ${error.response?.statusCode}");
          debugPrint("❌ Error Data: ${error.response?.data}");

          if (error.response?.statusCode == 401) {
            debugPrint("🚪 Unauthorized - clearing storage");
            await LocalStorage.clear();
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
      options: headers != null
          ? Options(
        headers: {
          ..._dio.options.headers,
          ...headers,
        },
      )
          : null,
    );
  }
}