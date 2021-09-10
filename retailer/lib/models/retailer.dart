class Retailer {
  final String rid;
  final String name;
  final String phone;
  final String state;
  final String email;

  Retailer({
    required this.rid,
    required this.name,
    required this.phone,
    required this.state,
    required this.email,
  });

  factory Retailer.fromJson(Map<String, Object?> json) {
    return Retailer(
      rid: json['rid'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'rid': rid,
      'name': name,
      'phone': phone,
      'state': state,
      'email': email,
    };
  }
}
