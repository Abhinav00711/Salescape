import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../services/firestore_service.dart';

class CartProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<CartItem> _items = [];

  /// An unmodifiable view of the items in the cart.
  Future<List<CartItem>> get items =>
      Future.delayed(Duration(seconds: 0)).then((_) => _items);

  /// The current total price of all items .
  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.price;
    }
    return double.parse((total).toStringAsFixed(2));
  }

  String get totalItems => _items.length.toString();

  Future<bool> add(CartItem item) async {
    if (_items.isNotEmpty) {
      if (await _isSameWholesaler(item)) {
        if (!_isRedundant(item)) {
          _items.add(item);
        }
      } else {
        return false;
      }
    } else {
      _items.add(item);
    }
    notifyListeners();
    return true;
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void remove(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  Future<bool> _isSameWholesaler(CartItem item) async {
    String wid1 = await FirestoreService()
        .getProduct(_items[0].pid)
        .then((product) => product!.wid);
    String wid2 = await FirestoreService()
        .getProduct(item.pid)
        .then((product) => product!.wid);
    if (wid1 == wid2) {
      return true;
    }
    return false;
  }

  bool _isRedundant(CartItem item) {
    for (var i in _items.where((element) => element.pid == item.pid)) {
      if (i.item == item.item) {
        CartItem newItem = CartItem(
          pid: item.pid,
          item: item.item,
          quantity: (item.quantity + i.quantity),
          price: (item.price + i.price),
          unit: item.unit,
        );
        _items[_items.indexOf(i)] = newItem;
        return true;
      }
    }
    return false;
  }

  void increaseQuantity(CartItem item) {
    for (var i in _items.where((element) => element.pid == item.pid)) {
      if (i.item == item.item) {
        CartItem newItem = CartItem(
          pid: item.pid,
          item: item.item,
          quantity: (i.quantity + 1),
          price: (i.price + (i.price / i.quantity)),
          unit: item.unit,
        );
        _items[_items.indexOf(i)] = newItem;
      }
    }
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    for (var i in _items.where((element) => element.pid == item.pid)) {
      if (i.item == item.item) {
        CartItem newItem = CartItem(
          pid: item.pid,
          item: item.item,
          quantity: (i.quantity - 1),
          price: (i.price - (i.price / i.quantity)),
          unit: item.unit,
        );
        _items[_items.indexOf(i)] = newItem;
      }
    }
    notifyListeners();
  }
}
