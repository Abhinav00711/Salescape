import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import './cart_item.dart';

enum OrderStatus {
  pending,
  accepted,
  completed,
}

class Order {
  final String rid;
  final String oid;
  final List<CartItem> items;
  final OrderStatus status;
  final int total;
  final DateTime dateTime;

  Order({
    required this.rid,
    required this.oid,
    required this.items,
    required this.total,
    required this.dateTime,
    required this.status,
  });

  factory Order.fromJson(Map<String, Object?> json) {
    return Order(
      rid: json['rid'] as String,
      oid: json['oid'] as String,
      items: (jsonDecode(json['items'] as String) as List)
          .map((i) => CartItem.fromJson(i))
          .toList(),
      total: json['total'] as int,
      status: OrderStatus.values.elementAt(json['status'] as int),
      dateTime: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'rid': rid,
      'oid': oid,
      'items': jsonEncode(items),
      'total': total,
      'date': dateTime,
      'status': status.index,
    };
  }
}
