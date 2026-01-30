// DPR Model
import '../MaterialScreen/MaterialModal.dart';
import 'LabourModal.dart';

class DPRModel {
  final String date;
  final int projectId;
  final String weatherConditions;
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
    return {
      "date": date,
      "project_id": projectId,
      "weather_conditions": weatherConditions,
      "safety_incidents": safetyIncidents,
      "remarks": remarks,
      "submitted_by": submittedBy,
      "material_cost": materialCost,
      "labour_cost": labourCost,
      "machinery_cost": machineryCost,
      "total_cost": totalCost,
      "materials": materials.map((e) => e.toJson()).toList(),
      "labour_consumptions":
      labourConsumptions.map((e) => e.toJson()).toList(),
      "machinery": machinery.map((e) => e.toJson()).toList(),
      "file_ids": fileIds,
    };
  }
}

// ---------------- MATERIAL ----------------
class DPRMaterial {
  MaterialItem? material;
  String? quantity;
  String? rate;
  String? amount;
  String? chainageFrom;
  String? chainageTo;

  DPRMaterial();

  Map<String, dynamic> toJson() => {
    "stock_id": material?.id,
    "quantity": quantity ?? "0",
    "rate": rate ?? "0",
    "amount": amount ?? "0",
    "chainage_from": chainageFrom,
    "chainage_to": chainageTo,
  };
}

// ---------------- LABOUR ----------------
class DPRLabourConsumption {
  LabourItem? labour;
  String? hours;
  String? charges;
  String? chainageFrom;
  String? chainageTo;

  DPRLabourConsumption();

  Map<String, dynamic> toJson() => {
    "labour_id": labour?.id,
    "hours": hours ?? "0",
    "charges": charges ?? "0",
    "chainage_from": chainageFrom,
    "chainage_to": chainageTo,
  };
}

// ---------------- MACHINERY ----------------
class DPRMachinery {
  String? machineCode;
  String? machineName;
  String? chainageFrom;
  String? chainageTo;
  String? workingHours;
  String? fuelType;
  String? fuelConsumed;
  String? fuelAmount;

  DPRMachinery();

  Map<String, dynamic> toJson() => {
    "machine_code": machineCode,
    "machine_name": machineName,
    "chainage_from": chainageFrom,
    "chainage_to": chainageTo,
    "working_hours": workingHours,
    "fuel_type": fuelType,
    "fuel_consumed": fuelConsumed,
    "fuel_amount": fuelAmount ?? "0",
  };
}
