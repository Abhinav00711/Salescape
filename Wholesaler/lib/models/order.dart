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
  final String wid;
  final String? did;
  final List<CartItem> items;
  final OrderStatus status;
  final double total;
  final DateTime dateTime;

  Order({
    required this.rid,
    required this.oid,
    required this.wid,
    this.did,
    required this.items,
    required this.total,
    required this.dateTime,
    required this.status,
  });

  factory Order.fromJson(Map<String, Object?> json) {
    return Order(
      rid: json['rid'] as String,
      oid: json['oid'] as String,
      wid: json['wid'] as String,
      did: json['did'] == null ? null : json['did'] as String,
      items: (jsonDecode(json['items'] as String) as List)
          .map((i) => CartItem.fromJson(i))
          .toList(),
      total: json['total'] as double,
      status: OrderStatus.values.elementAt(json['status'] as int),
      dateTime: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'rid': rid,
      'oid': oid,
      'wid': wid,
      'did': did,
      'items': jsonEncode(items),
      'total': total,
      'date': dateTime,
      'status': status.index,
    };
  }
}