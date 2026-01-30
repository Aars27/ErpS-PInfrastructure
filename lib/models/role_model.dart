import 'package:smp_erp/models/permission_model.dart';



class RoleModel {
  final String name;
  final List<PermissionModel> permissions;

  RoleModel({required this.name, required this.permissions});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json['name'],
      permissions: (json['permissions'] as List)
          .map((e) => PermissionModel.fromJson(e))
          .toList(),
    );
  }
}
