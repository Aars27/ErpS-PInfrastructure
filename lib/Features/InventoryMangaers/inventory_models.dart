class InventoryUserModel {
  final int id;
  final String name;
  final String email;
  final String mobile;

  InventoryUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory InventoryUserModel.fromJson(Map<String, dynamic> json) {
    return InventoryUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobileNumber'],
    );
  }
}



class InventoryLocationModel {
  final String country;
  final String state;
  final String district;
  final String village;
  final String pincode;

  InventoryLocationModel({
    required this.country,
    required this.state,
    required this.district,
    required this.village,
    required this.pincode,
  });

  factory InventoryLocationModel.fromJson(Map<String, dynamic> json) {
    return InventoryLocationModel(
      country: json['country'],
      state: json['state'],
      district: json['district'],
      village: json['village'],
      pincode: json['pincode'],
    );
  }
}

