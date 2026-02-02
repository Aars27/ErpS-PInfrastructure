class ApiConstants {

  static const String authBaseUrl =
      'https://m1qgkrd1-4043.inc1.devtunnels.ms/api';
      // 'http://192.168.29.196:4043/api';


  static const String appBaseUrl =
      'https://m1qgkrd1-4242.inc1.devtunnels.ms/api';
      // 'http://192.168.29.196:4242/api';


  // Auth
  static const String login = '/user/login';

  // Project
  static const String projects = '/project';

  // Inventory
  static const String inventoryManager = '/inventory-manager';

  static const String stock = '/stock';

  // Material & PR
  static const String material = '/material';


  static const String pr = '/pr';

  static const String labour = '/labour';


  static const String dpr = '/dpr';

  // Unit endpoints
  static const String unit = '/unit';

  // ApiConstants.dart
  static const String category = '/category';
  //grn
  static const String grn = '/grn';


  static String submitPr(int id) => '/pr/$id/submit';


  // Headers
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  static Map<String, String> inventoryHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'Authorization': 'Bearer $token',
    'x-module': 'Inventory Management',
    'action-perform': 'create',
  };
}
