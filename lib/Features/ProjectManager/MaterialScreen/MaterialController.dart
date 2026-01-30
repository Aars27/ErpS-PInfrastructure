import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../Constants/ApiConstants.dart';
import 'Materailservices.dart';
import 'MaterialModal.dart';


class MaterialController {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.appBaseUrl,
    headers: ApiConstants.headers,
  ));

  Future<List<MaterialItem>> fetchMaterials() async {
    final res = await _dio.get(ApiConstants.material);

    debugPrint('MATERIAL API RESPONSE => ${res.data}');

    final List list = res.data;

    return list.map((e) => MaterialItem.fromJson(e)).toList();
  }
}





// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import '../../../Constants/ApiConstants.dart';
// import '../../../Constants/ApiService.dart';
// import '../MaterialScreen/MaterialModal.dart';
//
// class MaterialController {
//   final ApiService _api = ApiService(type: ApiType.app);
//
//   Future<List<MaterialItem>> fetchMaterials() async {
//     try {
//       final Response response = await _api.get(
//         ApiConstants.material,
//         headers: {'x-module': 'Inventory Management'},
//       );
//
//       // 1) PRINT RAW RESPONSE
//       debugPrint("MATERIAL API RAW: ${response.data}");
//
//       /// ADJUST HERE BASED ON RETURN STRUCTURE
//       final raw = response.data;
//
//       List materialsList;
//
//       // If your API returns { "data": [ ... ] }
//       if (raw['data'] is List) {
//         materialsList = raw['data'];
//       }
//       // If API returns { "materials": [ ... ] }
//       else if (raw['materials'] is List) {
//         materialsList = raw['materials'];
//       }
//       else {
//         throw Exception("Unexpected material key in response");
//       }
//
//       return materialsList
//           .map((e) => MaterialItem.fromJson(e))
//           .toList();
//     } on DioError catch (e) {
//       debugPrint("Material Fetch Error: ${e.response?.data}");
//       rethrow;
//     }
//   }
// }
