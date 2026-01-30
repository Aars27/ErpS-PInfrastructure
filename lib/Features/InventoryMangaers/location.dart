class LocationModel {
  final String country;
  final String state;
  final String district;
  final String village;
  final String pincode;

  LocationModel({
    required this.country,
    required this.state,
    required this.district,
    required this.village,
    required this.pincode,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      country: json['country'],
      state: json['state'],
      district: json['district'],
      village: json['village'],
      pincode: json['pincode'],
    );
  }
}
