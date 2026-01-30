
import 'modulemodal.dart';

class PermissionModel {
  final List<String> actions;
  final List<ModuleModel> modules;

  PermissionModel({
    required this.actions,
    required this.modules,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      actions: List<String>.from(json['action']),
      modules: (json['modules'] as List)
          .map((e) => ModuleModel.fromJson(e))
          .toList(),
    );
  }
}
