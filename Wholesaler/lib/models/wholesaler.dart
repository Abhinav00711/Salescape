class Wholesaler {
  final String wid;
  final String name;
  final String phone;
  final String state;
  final String email;
  final String industry;

  Wholesaler({
    required this.wid,
    required this.name,
    required this.phone,
    required this.state,
    required this.email,
    required this.industry,
  });

  factory Wholesaler.fromJson(Map<String, Object?> json) {
    return Wholesaler(
      wid: json['wid'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      email: json['email'] as String,
      industry: json['industry'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'wid': wid,
      'name': name,
      'phone': phone,
      'state': state,
      'email': email,
      'industry': industry,
    };
  }
}
