// DPR Model - Corrected for Backend
class DPRModel {
  final String date;
  final int projectId;
  final String weatherConditions;
  final String dimension;
  final String safetyIncidents;
  final String remarks;
  final int submittedBy;
  final double materialCost;
  final double labourCost;
  final double machineryCost;
  final double totalCost;
  final List<DPRMaterial> materials;
  final List<DPRLabourConsumption> labourConsumptions;
  final List<DPRMachinery> machinery;
  final List<int> fileIds;

  DPRModel({
    required this.date,
    required this.projectId,
    required this.weatherConditions,
    required this.dimension,
    required this.safetyIncidents,
    required this.remarks,
    required this.submittedBy,
    required this.materialCost,
    required this.labourCost,
    required this.machineryCost,
    required this.totalCost,
    required this.materials,
    required this.labourConsumptions,
    required this.machinery,
    required this.fileIds,
  });

  Map<String, dynamic> toJson() {
    final json = {
      "date": date,
      "project_id": projectId,
      "weather_conditions": weatherConditions,
      "Dimension": dimension,
      "safety_incidents": safetyIncidents,
      "remarks": remarks,
      "submitted_by": submittedBy,
      "material_cost": materialCost,
      "labour_cost": labourCost,
      "machinery_cost": machineryCost,
      "total_cost": totalCost,
      "materials": materials.map((m) => m.toJson()).toList(),
      "labour_consumptions": labourConsumptions.map((l) => l.toJson()).toList(),
      "machinery": machinery.map((m) => m.toJson()).toList(),
      "file_ids": fileIds,
    };

    // Print for debugging
    print('📤 DPR Request Body:');
    print('=====================================');
    print(json);
    print('=====================================');

    return json;
  }
}

// DPR Material Model
class DPRMaterial {
  int? materialId;
  String quantity;
  String rate;
  String amount;
  String chainageFrom;
  String chainageTo;

  DPRMaterial({
    this.materialId,
    this.quantity = '',
    this.rate = '',
    this.amount = '',
    this.chainageFrom = '',
    this.chainageTo = '',
  });

  Map<String, dynamic> toJson() {
    final qty = double.tryParse(quantity) ?? 0;
    final rt = double.tryParse(rate) ?? 0;
    final amt = double.tryParse(amount) ?? 0;

    return {
      "material_id": materialId,
      "quantity": qty,
      "rate": rt,
      "amount": amt,
      "chainage_from": chainageFrom,
      "chainage_to": chainageTo,
    };
  }
}


// DPR Labour Consumption Model
class DPRLabourConsumption {
  String? skill;
  String hours;
  String charges;
  String chainageFrom;
  String chainageTo;
  List<int> labourIds;

  DPRLabourConsumption({
    this.skill,
    this.hours = '',
    this.charges = '',
    this.chainageFrom = '',
    this.chainageTo = '',
    this.labourIds = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      "skill": skill,
      "hours": double.tryParse(hours) ?? 0,
      "charges": double.tryParse(charges) ?? 0,
      "chainage_from": chainageFrom,
      "chainage_to": chainageTo,
      "labour_ids": labourIds,
    };
  }
}

// DPR Machinery Model
class DPRMachinery {
  String machineCode;
  String machineName;
  String chainageFrom;
  String chainageTo;
  String workingHours;
  String fuelType;
  String fuelConsumed;
  String fuelAmount;

  DPRMachinery({
    this.machineCode = '',
    this.machineName = '',
    this.chainageFrom = '',
    this.chainageTo = '',
    this.workingHours = '',
    this.fuelType = '',
    this.fuelConsumed = '',
    this.fuelAmount = '',
  });

  Map<String, dynamic> toJson() {
    // Remove ₹ symbol from fuel amount
    final cleanAmount = fuelAmount.replaceAll('₹', '').replaceAll(',', '').trim();

    return {
      "machine_code": machineCode,
      "machine_name": machineName,
      "chainage_from": chainageFrom,
      "chainage_to": chainageTo,
      "working_hours": double.tryParse(workingHours) ?? 0,
      "fuel_type": fuelType,
      "fuel_consumed": fuelConsumed,
      "fuel_amount": cleanAmount,
    };
  }
}