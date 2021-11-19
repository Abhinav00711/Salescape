class DeliveryLocation {
  final String did;
  final double latitude;
  final double longitude;

  DeliveryLocation({
    required this.did,
    required this.latitude,
    required this.longitude,
  });

  factory DeliveryLocation.fromJson(Map<String, Object?> json) {
    return DeliveryLocation(
      did: json['did'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  DeliveryLocation.fromMap(Map<String, dynamic> map)
      : did = map['did'],
        latitude = map['latitude'],
        longitude = map['longitude'];

  Map<String, Object?> toJson() {
    return {
      'did': did,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
