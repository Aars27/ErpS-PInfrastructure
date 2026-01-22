
import 'package:smp_erp/LoginResponseDirectory/Permission.dart';

class Role {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  final List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      permissions: (json['permissions'] as List)
          .map((p) => Permission.fromJson(p))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'permissions': permissions.map((p) => p.toJson()).toList(),
    };
  }
}