class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String roleName;
  final String createdAt;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.roleName,
    required this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobileNumber'] ?? '',
      roleName: json['role']?['name'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
