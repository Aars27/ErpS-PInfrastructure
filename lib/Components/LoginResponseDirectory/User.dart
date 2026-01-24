import 'package:smp_erp/LoginResponseDirectory/Role.dart';

class User {
  final int id;
  final String name;
  final String email;
  final bool emailVerified;
  final int? fileId;
  final String? originalPassword;
  final String mobileNumber;
  final int roleId;
  final String createdAt;
  final String updatedAt;
  final String provider;
  final String? profileImage;
  final Role role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    this.fileId,
    this.originalPassword,
    required this.mobileNumber,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.provider,
    this.profileImage,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      fileId: json['fileId'],
      originalPassword: json['original_password'],
      mobileNumber: json['mobileNumber'],
      roleId: json['roleId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      provider: json['provider'],
      profileImage: json['profileImage'],
      role: Role.fromJson(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerified': emailVerified,
      'fileId': fileId,
      'original_password': originalPassword,
      'mobileNumber': mobileNumber,
      'roleId': roleId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'provider': provider,
      'profileImage': profileImage,
      'role': role.toJson(),
    };
  }
}