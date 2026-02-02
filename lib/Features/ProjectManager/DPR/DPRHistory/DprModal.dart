class DPRListItem {
  final int id;
  final String date;
  final int projectId;
  final String weatherConditions;
  final String safetyIncidents;
  final String remarks;
  final double materialCost;
  final double labourCost;
  final double machineryCost;
  final double totalCost;
  final int materialsCount;
  final int laboursCount;
  final int machineryCount;
  final int filesCount;

  DPRListItem({
    required this.id,
    required this.date,
    required this.projectId,
    required this.weatherConditions,
    required this.safetyIncidents,
    required this.remarks,
    required this.materialCost,
    required this.labourCost,
    required this.machineryCost,
    required this.totalCost,
    required this.materialsCount,
    required this.laboursCount,
    required this.machineryCount,
    required this.filesCount,
  });

  factory DPRListItem.fromJson(Map<String, dynamic> json) {
    return DPRListItem(
      id: json['id'],
      date: json['date'],
      projectId: json['project_id'],
      weatherConditions: json['weather_conditions'] ?? '',
      safetyIncidents: json['safety_incidents'] ?? '',
      remarks: json['remarks'] ?? '',
      materialCost: (json['material_cost'] ?? 0).toDouble(),
      labourCost: (json['labour_cost'] ?? 0).toDouble(),
      machineryCost: (json['machinery_cost'] ?? 0).toDouble(),
      totalCost: (json['total_cost'] ?? 0).toDouble(),
      materialsCount: json['materials_count'] ?? 0,
      laboursCount: json['labours_count'] ?? 0,
      machineryCount: json['machinery_count'] ?? 0,
      filesCount: json['files_count'] ?? 0,
    );
  }
}