import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import './cart_item.dart';

enum OrderStatus {
  pending,
  accepted,
  completed,
  start,
}

class Order {
  final String rid;
  final String oid;
  final String wid;
  final String did;
  final String bname;
  final List<CartItem> items;
  final OrderStatus status;
  final double total;
  final DateTime dateTime;
  final String otp;

  Order({
    required this.rid,
    required this.oid,
    required this.wid,
    this.did = '',
    required this.bname,
    required this.items,
    required this.total,
    required this.dateTime,
    required this.status,
    required this.otp,
  });

  factory Order.fromJson(Map<String, Object?> json) {
    return Order(
      rid: json['rid'] as String,
      oid: json['oid'] as String,
      wid: json['wid'] as String,
      did: json['did'] as String,
      bname: json['bname'] as String,
      items: (jsonDecode(json['items'] as String) as List)
          .map((i) => CartItem.fromJson(i))
          .toList(),
      total: json['total'] as double,
      status: OrderStatus.values.elementAt(json['status'] as int),
      dateTime: (json['date'] as Timestamp).toDate(),
      otp: (json['otp'] as String),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'rid': rid,
      'oid': oid,
      'wid': wid,
      'did': did,
      'bname': bname,
      'items': jsonEncode(items),
      'total': total,
      'date': dateTime,
      'status': status.index,
      'otp': otp,
    };
  }
}
