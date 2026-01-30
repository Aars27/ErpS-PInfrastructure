class ModuleModel {
  final int id;
  final String name;
  final String description;

  ModuleModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      id: json['id'],
      name: json['Name'],
      description: json['description'],
    );
  }
}
