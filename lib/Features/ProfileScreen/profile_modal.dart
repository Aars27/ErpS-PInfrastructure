import 'Profilemodal.dart';

class ProfileUserModel {
  final String name;
  final String email;
  final String role;
  final List<ProfilePermissionModel> permissions;

  ProfileUserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.permissions,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      name: json['name'],
      email: json['email'],
      role: json['role']['name'],
      permissions: (json['role']['permissions'] as List)
          .map((e) => ProfilePermissionModel.fromJson(e))
          .toList(),
    );
  }
}
