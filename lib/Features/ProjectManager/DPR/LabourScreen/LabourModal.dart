class LabourItem {
  final int id;
  final String name;
  final String skill;
  final String phoneNumber;

  LabourItem({
    required this.id,
    required this.name,
    required this.skill,
    required this.phoneNumber,
  });

  factory LabourItem.fromJson(Map<String, dynamic> json) {
    return LabourItem(
      id: json['id'],
      name: json['labour_name'],
      skill: json['skill'],
      phoneNumber: json['phone_number'],
    );
  }
}