class Project {
  final int id;
  final String projectType;
  final String projectName;
  final String projectCode;
  final String status;
  final String client;
  final String startDate;
  final String endDate;
  final int progress;

  final String state;
  final String district;
  final String village;

  Project({
    required this.id,
    required this.projectType,
    required this.projectName,
    required this.projectCode,
    required this.status,
    required this.client,
    required this.startDate,
    required this.endDate,
    required this.progress,
    required this.state,
    required this.district,
    required this.village,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      projectType: json['project_type'],
      projectName: json['project_name'],
      projectCode: json['project_code'],
      status: json['status'],
      client: json['client'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      progress: json['progress'],
      state: json['project_location']['state'],
      district: json['project_location']['district'],
      village: json['project_location']['village'],
    );
  }
}
