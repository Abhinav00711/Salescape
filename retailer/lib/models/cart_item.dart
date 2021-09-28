class CartItem {
  final String pid;
  final String item;
  final int quantity;
  final int price;

  CartItem({
    required this.pid,
    required this.item,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, Object?> json) {
    return CartItem(
      pid: json['pid'] as String,
      item: json['item'] as String,
      quantity: json['quantity'] as int,
      price: json['price'] as int,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'pid': pid,
      'item': item,
      'quantity': quantity,
      'price': price,
    };
  }
}
