class Product {
  final String pid;
  final String wid;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String imageUrl;

  Product({
    required this.pid,
    required this.wid,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, Object?> json) {
    return Product(
      pid: json['pid'] as String,
      wid: json['wid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: double.parse(json['price'].toString()),
      stock: json['stock'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'pid': pid,
      'wid': wid,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
    };
  }
}
