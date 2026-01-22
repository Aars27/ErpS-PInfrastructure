import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smp_erp/Constants/ApiConstants.dart';
import 'package:smp_erp/SharedPreffrence/SharedPreferencesHelper.dart';


class ApiService {

  static Future<dynamic> get(String endpoint, {bool requiresAuth = true}) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl1}$endpoint');

      Map<String, String> headers = ApiConstants.headers;

      if (requiresAuth) {
        final token = await SharedPreferencesHelper.getAccessToken();
        if (token != null) {
          headers = ApiConstants.getAuthHeaders(token);
        }
      }

      final response = await http.get(url, headers: headers);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // POST Request
  static Future<dynamic> post(
      String endpoint,
      dynamic body, {
        bool requiresAuth = false,
      }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      Map<String, String> headers = ApiConstants.headers;

      if (requiresAuth) {
        final token = await SharedPreferencesHelper.getAccessToken();
        if (token != null) {
          headers = ApiConstants.getAuthHeaders(token);
        }
      }

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  static Future<dynamic> postMaterial(
      String endpoint,
      dynamic body, {
        bool requiresAuth = false,
      }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl1}$endpoint');

      Map<String, String> headers = ApiConstants.headered;

      if (requiresAuth) {
        final token = await SharedPreferencesHelper.getAccessToken();
        if (token != null) {
          headers = ApiConstants.getAuthHeaders(token);
        }
      }

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  // PUT Request
  static Future<dynamic> put(
      String endpoint,
      dynamic body, {
        bool requiresAuth = true,
      }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      Map<String, String> headers = ApiConstants.headers;

      if (requiresAuth) {
        final token = await SharedPreferencesHelper.getAccessToken();
        if (token != null) {
          headers = ApiConstants.getAuthHeaders(token);
        }
      }

      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // DELETE Request
  static Future<dynamic> delete(
      String endpoint, {
        bool requiresAuth = true,
      }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      Map<String, String> headers = ApiConstants.headers;

      if (requiresAuth) {
        final token = await SharedPreferencesHelper.getAccessToken();
        if (token != null) {
          headers = ApiConstants.getAuthHeaders(token);
        }
      }

      final response = await http.delete(url, headers: headers);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Handle Response
  static dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: ${response.body}');
      case 403:
        throw Exception('Forbidden: ${response.body}');
      case 404:
        throw Exception('Not found: ${response.body}');
      case 500:
        throw Exception('Server error: ${response.body}');
      default:
        throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}