class MaterialModel {
  final int id;
  final String name;
  final String materialCode;
  final int categoryId;
  final int unitId;
  final String status;
  final int minimumThresholdQuantity;
  final String unitOfMeasure;
  final String specifications;
  final String createdAt;
  final String updatedAt;
  final Category? category;
  final Unit? unit;

  MaterialModel({
    required this.id,
    required this.name,
    required this.materialCode,
    required this.categoryId,
    required this.unitId,
    required this.status,
    required this.minimumThresholdQuantity,
    required this.unitOfMeasure,
    required this.specifications,
    required this.createdAt,
    required this.updatedAt,
    this.category,
    this.unit,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      materialCode: json['material_code'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      unitId: json['unitId'] ?? 0,
      status: json['status'] ?? '',
      minimumThresholdQuantity: json['minimum_threshold_quantity'] ?? 0,
      unitOfMeasure: json['unit_of_measure'] ?? '',
      specifications: json['specifications'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      unit: json['unit'] != null
          ? Unit.fromJson(json['unit'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'material_code': materialCode,
      'categoryId': categoryId,
      'unitId': unitId,
      'status': status,
      'minimum_threshold_quantity': minimumThresholdQuantity,
      'unit_of_measure': unitOfMeasure,
      'specifications': specifications,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'category': category?.toJson(),
      'unit': unit?.toJson(),
    };
  }
}

class Category {
  final int id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class Unit {
  final int id;
  final String name;
  final String description;

  Unit({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class MaterialResponse {
  final int status;
  final List<MaterialModel> materials;
  final Pagination pagination;

  MaterialResponse({
    required this.status,
    required this.materials,
    required this.pagination,
  });

  factory MaterialResponse.fromJson(Map<String, dynamic> json) {
    return MaterialResponse(
      status: json['status'] ?? 200,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((item) => MaterialModel.fromJson(item))
          .toList() ??
          [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : Pagination(page: 1, limit: 10, total: 0, pages: 0),
    );
  }
}

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int pages;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 0,
    );
  }
}