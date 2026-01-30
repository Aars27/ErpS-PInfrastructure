class LabourItem {
  final int id;
  final String name;

  LabourItem({
    required this.id,
    required this.name,
  });

  factory LabourItem.fromJson(Map<String, dynamic> json) {
    return LabourItem(
      id: json['id'],
      // ✅ name null ho to code dikhao
      name: json['name'] ?? json['code'] ?? 'Labour',
    );
  }
}
