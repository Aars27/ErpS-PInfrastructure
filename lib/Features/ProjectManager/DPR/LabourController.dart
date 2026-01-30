import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../Constants/ApiConstants.dart';
import 'LabourModal.dart';

class LabourController {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.appBaseUrl,
    headers: ApiConstants.headers,
  ));

  Future<List<LabourItem>> fetchLabours() async {
    final res = await _dio.get(ApiConstants.labour);

    debugPrint('LABOUR API => ${res.data}');

    final List list = res.data; // ✅ direct list

    return list.map((e) => LabourItem.fromJson(e)).toList();
  }
}
