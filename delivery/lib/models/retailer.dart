class Retailer {
  final String rid;
  final String name;
  final String phone;
  final String state;
  final String email;
  final String delivery_address;

  Retailer({
    required this.rid,
    required this.name,
    required this.phone,
    required this.state,
    required this.email,
    required this.delivery_address,
  });

  factory Retailer.fromJson(Map<String, Object?> json) {
    return Retailer(
      rid: json['rid'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      email: json['email'] as String,
      delivery_address: json['DAddress'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'rid': rid,
      'name': name,
      'phone': phone,
      'state': state,
      'email': email,
      'DAddress': delivery_address,
    };
  }
}
