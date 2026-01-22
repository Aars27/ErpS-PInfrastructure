// lib/Constants/ApiConstants.dart

class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://m1qgkrd1-4043.inc1.devtunnels.ms/api';
  static const String baseUrl1 = 'https://m1qgkrd1-4242.inc1.devtunnels.ms/api';

  // Endpoints
  static const String login = '/user/login';
  static const String logout = '/user/logout';
  static const String refreshToken = '/user/refresh-token';

  // Project endpoints
  static const String projects = '/project';

  // Stock endpoints
  static const String stock = '/stock';
  static const String addStock = '/stock/add';

  // Material Request endpoints
  static const String materialRequests = '/material-requests';
  static const String approveMaterialRequest = '/material-requests/approve';
  static const String rejectMaterialRequest = '/material-requests/reject';

  // Material endpoints
  static const String material = '/material';
  static const String pr = '/pr';

  // Vendor endpoints
  static const String vendors = '/vendors';

  // User endpoints
  static const String users = '/users';

  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
  };

  static Map<String, String> get headered => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'x-module':'Inventory',
    'Accept-Encoding': 'gzip, deflate, br',
  };

  static Map<String, String> getAuthHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'x-module':'Inventory',
    'action-perform':'create',
    'Accept-Encoding': 'gzip, deflate, br',
    'Authorization': 'Bearer $token',
  };
}