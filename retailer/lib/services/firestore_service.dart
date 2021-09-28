import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retailer/models/order.dart';

import '../models/retailer.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  // User Services

  Future<void> addUser(Retailer userData) async {
    var _userRef = _firestore.collection('retailers').withConverter<Retailer>(
          fromFirestore: (snapshots, _) => Retailer.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    await _userRef.doc(userData.rid).set(userData);
  }

  Future<Retailer?> getUser(String rid) async {
    var _userRef = _firestore.collection('retailers').withConverter<Retailer>(
          fromFirestore: (snapshots, _) => Retailer.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return (await _userRef.doc(rid).get()).data();
  }

  Future<void> updateUser(Retailer userData) async {
    var _userRef = _firestore.collection('wholesalers').withConverter<Retailer>(
          fromFirestore: (snapshots, _) => Retailer.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    await _userRef.doc(userData.rid).set(userData);
  }

  // Orders

  Future<List<Order>> getAllUserOrders(String rid) async {
    var _orderRef = _firestore.collection('orders').withConverter<Order>(
          fromFirestore: (snapshots, _) => Order.fromJson(snapshots.data()!),
          toFirestore: (order, _) => order.toJson(),
        );
    List<Order> orderList = [];
    List<QueryDocumentSnapshot<Order>> orders = await _orderRef
        .where('rid', isEqualTo: rid)
        .get()
        .then((orders) => orders.docs);
    for (var order in orders) {
      orderList.add(order.data());
    }
    return orderList;
  }

  Future<List<Order>> getPendingUserOrders(String rid) async {
    List<Order> orderList = await getAllUserOrders(rid);
    List<Order> pendingList = [];
    for (var order in orderList) {
      if (order.status == OrderStatus.pending) {
        pendingList.add(order);
      }
    }
    return pendingList;
  }

  Future<List<Order>> getAcceptedUserOrders(String rid) async {
    List<Order> orderList = await getAllUserOrders(rid);
    List<Order> acceptedList = [];
    for (var order in orderList) {
      if (order.status == OrderStatus.accepted) {
        acceptedList.add(order);
      }
    }
    return acceptedList;
  }

  Future<List<Order>> getCompletedUserOrders(String rid) async {
    List<Order> orderList = await getAllUserOrders(rid);
    List<Order> completedList = [];
    for (var order in orderList) {
      if (order.status == OrderStatus.completed) {
        completedList.add(order);
      }
    }
    return completedList;
  }
}
