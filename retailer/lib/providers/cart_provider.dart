import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<CartItem> _items = [];

  /// An unmodifiable view of the items in the cart.
  Future<List<CartItem>> get items =>
      Future.delayed(Duration(seconds: 0)).then((_) => _items);

  /// The current total price of all items .
  int get totalPrice {
    int total = 0;
    for (var item in _items) {
      total += item.price;
    }
    return total;
  }

  String get totalItems => _items.length.toString();

  void add(CartItem item) {
    if (!_isRedundant(item)) {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void remove(CartItem item) {
    _items.remove(item);
  }

  bool _isRedundant(CartItem item) {
    for (var i in _items.where((element) => element.pid == item.pid)) {
      if (i.item == item.item) {
        CartItem newItem = CartItem(
          pid: item.pid,
          item: item.item,
          quantity: (item.quantity + i.quantity),
          price: (item.price + i.price),
        );
        _items[_items.indexOf(i)] = newItem;
        return true;
      }
    }
    return false;
  }
}
