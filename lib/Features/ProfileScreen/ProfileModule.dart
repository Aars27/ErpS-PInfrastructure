class ProfileModuleModel {
  final int id;
  final String name;
  final String description;

  ProfileModuleModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ProfileModuleModel.fromJson(Map<String, dynamic> json) {
    return ProfileModuleModel(
      id: json['id'],
      name: json['Name'],
      description: json['description'],
    );
  }
}
