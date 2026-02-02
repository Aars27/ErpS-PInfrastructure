import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smp_erp/Features/mainInventorymanagement/grn/grn_Controller.dart';
import '../../ProjectManager/DPR/File_upload_controller.dart';
import 'package:image_picker/image_picker.dart';



class GRNCreateScreen extends StatefulWidget {
  const GRNCreateScreen({super.key});

  @override
  State<GRNCreateScreen> createState() => _GRNCreateScreenState();
}

class _GRNCreateScreenState extends State<GRNCreateScreen> {
  List<XFile> images = [];
  List<int> uploadedFileIds = [];

  Future<void> pickAndUpload() async {
    final picker = ImagePicker();
    images = await picker.pickMultiImage();
    uploadedFileIds = await FileUploadService().uploadFiles(images);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<GRNController>(
      builder: (context, c, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Create GRN')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: pickAndUpload,
                  child: const Text('Upload Photos'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: c.isLoading
                      ? null
                      : () {
                    c.createGRN(
                      poId: 1,
                      fileIds: uploadedFileIds,
                      materials: [
                        {
                          "material_id": 1,
                          "ordered": 100,
                          "accepted": 0,
                          "rejected": 0,
                          "received": 100,
                          "chainage": "Km 5+250",
                          "quality": null,
                        }
                      ],
                    );
                  },
                  child: c.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit GRN'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
