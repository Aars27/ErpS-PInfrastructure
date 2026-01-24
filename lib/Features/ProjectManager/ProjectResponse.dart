// lib/Models/ProjectModel.dart

class ProjectResponse {
  final int status;
  final List<ProjectModel> projects;
  final Meta meta;

  ProjectResponse({
    required this.status,
    required this.projects,
    required this.meta,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      status: json['status'] ?? 200,
      projects: (json['data'] as List?)
          ?.map((project) => ProjectModel.fromJson(project))
          .toList() ?? [],
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }
}

class ProjectModel {
  final int id;
  final String projectType;
  final String projectName;
  final String projectCode;
  final String location;
  final String startDate;
  final String endDate;
  final String budget;
  final String status;
  final String client;
  final String projectManager;
  final String description;
  final int progress;
  final HamDetails? hamDetails;
  final EpcDetails? epcDetails;
  final BotDetails? botDetails;

  ProjectModel({
    required this.id,
    required this.projectType,
    required this.projectName,
    required this.projectCode,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.budget,
    required this.status,
    required this.client,
    required this.projectManager,
    required this.description,
    required this.progress,
    this.hamDetails,
    this.epcDetails,
    this.botDetails,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? 0,
      projectType: json['project_type'] ?? '',
      projectName: json['project_name'] ?? '',
      projectCode: json['project_code'] ?? '',
      location: json['location'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      budget: json['budget'] ?? '',
      status: json['status'] ?? '',
      client: json['client'] ?? '',
      projectManager: json['project_manager'] ?? '',
      description: json['description'] ?? '',
      progress: json['progress'] ?? 0,
      hamDetails: json['ham_details'] != null
          ? HamDetails.fromJson(json['ham_details'])
          : null,
      epcDetails: json['epc_details'] != null
          ? EpcDetails.fromJson(json['epc_details'])
          : null,
      botDetails: json['bot_details'] != null
          ? BotDetails.fromJson(json['bot_details'])
          : null,
    );
  }
}

class HamDetails {
  final int id;
  final int projectId;
  final String annuityAmount;
  final int annuityPeriod;
  final int constructionPeriod;
  final String maintenanceResponsibility;
  final int progress;

  HamDetails({
    required this.id,
    required this.projectId,
    required this.annuityAmount,
    required this.annuityPeriod,
    required this.constructionPeriod,
    required this.maintenanceResponsibility,
    required this.progress,
  });

  factory HamDetails.fromJson(Map<String, dynamic> json) {
    return HamDetails(
      id: json['id'] ?? 0,
      projectId: json['project_id'] ?? 0,
      annuityAmount: json['annuity_amount'] ?? '',
      annuityPeriod: json['annuity_period'] ?? 0,
      constructionPeriod: json['construction_period'] ?? 0,
      maintenanceResponsibility: json['maintenance_responsibility'] ?? '',
      progress: json['progress'] ?? 0,
    );
  }
}

class EpcDetails {
  final int id;
  final int projectId;
  final String engineeringScope;
  final String procurementBudget;
  final String constructionTimeline;
  final String performanceGuarantee;
  final int progress;

  EpcDetails({
    required this.id,
    required this.projectId,
    required this.engineeringScope,
    required this.procurementBudget,
    required this.constructionTimeline,
    required this.performanceGuarantee,
    required this.progress,
  });

  factory EpcDetails.fromJson(Map<String, dynamic> json) {
    return EpcDetails(
      id: json['id'] ?? 0,
      projectId: json['project_id'] ?? 0,
      engineeringScope: json['engineering_scope'] ?? '',
      procurementBudget: json['procurement_budget'] ?? '',
      constructionTimeline: json['construction_timeline'] ?? '',
      performanceGuarantee: json['performance_guarantee'] ?? '',
      progress: json['progress'] ?? 0,
    );
  }
}

class BotDetails {
  final int id;
  final int projectId;
  final int concessionPeriod;
  final String estimatedOperatingCost;
  final bool tollRevenueCollectionEnabled;
  final String transferCondition;

  BotDetails({
    required this.id,
    required this.projectId,
    required this.concessionPeriod,
    required this.estimatedOperatingCost,
    required this.tollRevenueCollectionEnabled,
    required this.transferCondition,
  });

  factory BotDetails.fromJson(Map<String, dynamic> json) {
    return BotDetails(
      id: json['id'] ?? 0,
      projectId: json['project_id'] ?? 0,
      concessionPeriod: json['concession_period'] ?? 0,
      estimatedOperatingCost: json['estimated_operating_cost'] ?? '',
      tollRevenueCollectionEnabled: json['toll_revenue_collection_enabled'] ?? false,
      transferCondition: json['transfer_condition'] ?? '',
    );
  }
}

class Meta {
  final int page;
  final int limit;
  final int total;
  final int pages;
  final bool hasNext;
  final bool hasPrev;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 1,
      hasNext: json['hasNext'] ?? false,
      hasPrev: json['hasPrev'] ?? false,
    );
  }
}