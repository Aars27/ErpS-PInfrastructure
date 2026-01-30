import 'dart:io';
import 'package:dio/dio.dart';

import '../../../Constants/ApiService.dart';



class FileUploadController {
  final ApiService _api = ApiService();

  Future<int> uploadFile(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final response = await _api.post(
      '/file/upload',
      formData as Map<dynamic, dynamic>,
    );

    // backend returns uploaded file id
    return response.data['file']['id'];
  }
}
