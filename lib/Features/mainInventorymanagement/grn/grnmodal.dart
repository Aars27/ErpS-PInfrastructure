class GRN {
  final int id;
  final String gateEntry;
  final String vehicleNumber;
  final String status;
  final String receivedDate;
  final int totalReceived;

  GRN({
    required this.id,
    required this.gateEntry,
    required this.vehicleNumber,
    required this.status,
    required this.receivedDate,
    required this.totalReceived,
  });

  factory GRN.fromJson(Map<String, dynamic> json) {
    return GRN(
      id: json['id'],
      gateEntry: json['gate_entry_number'],
      vehicleNumber: json['vehicle_number'],
      status: json['status'],
      receivedDate: json['received_date'],
      totalReceived: json['total_received'],
    );
  }
}
