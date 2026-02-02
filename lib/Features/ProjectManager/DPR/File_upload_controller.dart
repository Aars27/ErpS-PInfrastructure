import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Core/Storage/local_storage.dart';

class FileUploadService {
  Future<List<int>> uploadFiles(List<XFile> files) async {
    try {
      final token = await LocalStorage.getToken();

      FormData formData = FormData();

      for (var file in files) {
        formData.files.add(
          MapEntry(
            'files',
            await MultipartFile.fromFile(
              file.path,
              filename: file.name,
            ),
          ),
        );
      }

      final dio = Dio(BaseOptions(
        baseUrl: ApiConstants.appBaseUrl,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'x-module': 'DPR Management',
        },
      ));

      final response = await dio.post('/file/upload', data: formData);

      print('✅ File upload response: ${response.data}');

      if (response.data['success'] == true) {
        List<int> fileIds = [];
        for (var fileData in response.data['data']) {
          fileIds.add(fileData['id']);
        }
        print('✅ Uploaded file IDs: $fileIds');
        return fileIds;
      } else {
        throw 'File upload failed';
      }
    } catch (e) {
      print('❌ File upload error: $e');
      rethrow;
    }
  }
}