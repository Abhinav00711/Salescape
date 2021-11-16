class CartItem {
  final String pid;
  final String item;
  final int quantity;
  final double price;
  final String unit;

  CartItem({
    required this.pid,
    required this.item,
    required this.quantity,
    required this.price,
    required this.unit,
  });

  factory CartItem.fromJson(Map<String, Object?> json) {
    return CartItem(
      pid: json['pid'] as String,
      item: json['item'] as String,
      quantity: json['quantity'] as int,
      price: json['price'] as double,
      unit: json['unit'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'pid': pid,
      'item': item,
      'quantity': quantity,
      'price': price,
      'unit': unit,
    };
  }
}
