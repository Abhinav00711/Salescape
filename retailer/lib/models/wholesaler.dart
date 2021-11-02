class Wholesaler {
  final String wid;
  final String name;
  final String bname;
  final String phone;
  final String state;
  final String email;
  final String industry;
  final String pickup_address;

  Wholesaler({
    required this.wid,
    required this.name,
    required this.bname,
    required this.phone,
    required this.state,
    required this.email,
    required this.industry,
    required this.pickup_address,
  });

  factory Wholesaler.fromJson(Map<String, Object?> json) {
    return Wholesaler(
      wid: json['wid'] as String,
      name: json['name'] as String,
      bname: json['bname'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      email: json['email'] as String,
      industry: json['industry'] as String,
      pickup_address: json['PAddress'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'wid': wid,
      'name': name,
      'bname': bname,
      'phone': phone,
      'state': state,
      'email': email,
      'industry': industry,
      'PAddress': pickup_address,
    };
  }
}
