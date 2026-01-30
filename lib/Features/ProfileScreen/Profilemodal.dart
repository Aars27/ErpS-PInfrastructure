

import 'ProfileModule.dart';

class ProfilePermissionModel {
  final List<String> actions;
  final List<ProfileModuleModel> modules;

  ProfilePermissionModel({
    required this.actions,
    required this.modules,
  });

  factory ProfilePermissionModel.fromJson(Map<String, dynamic> json) {
    return ProfilePermissionModel(
      actions: List<String>.from(json['action']),
      modules: (json['modules'] as List)
          .map((e) => ProfileModuleModel.fromJson(e))
          .toList(),
    );
  }
}
