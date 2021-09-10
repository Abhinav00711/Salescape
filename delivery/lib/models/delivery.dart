class Delivery {
  final String did;
  final String name;
  final String phone;
  final String state;
  final String email;
  final String status;

  Delivery({
    required this.did,
    required this.name,
    required this.phone,
    required this.state,
    required this.email,
    required this.status,
  });

  factory Delivery.fromJson(Map<String, Object?> json) {
    return Delivery(
      did: json['did'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'did': did,
      'name': name,
      'phone': phone,
      'state': state,
      'email': email,
      'status': status,
    };
  }
}
