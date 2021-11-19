import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/delivery.dart';
import '../models/order.dart';
import '../models/wholesaler.dart';
import '../models/retailer.dart';
import '../models/delivery_location.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  // User Services

  Future<void> addUser(Delivery userData) async {
    var _userRef = _firestore
        .collection('deliveryboys')
        .withConverter<Delivery>(
          fromFirestore: (snapshots, _) => Delivery.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    await _userRef.doc(userData.did).set(userData);
  }

  Future<Delivery?> getUser(String did) async {
    var _userRef = _firestore
        .collection('deliveryboys')
        .withConverter<Delivery>(
          fromFirestore: (snapshots, _) => Delivery.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return (await _userRef.doc(did).get()).data();
  }

  Future<Wholesaler?> getWholesaler(String wid) async {
    var _userRef =
        _firestore.collection('wholesalers').withConverter<Wholesaler>(
              fromFirestore: (snapshots, _) =>
                  Wholesaler.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    return (await _userRef.doc(wid).get()).data();
  }

  Future<Retailer?> getRetailer(String rid) async {
    var _userRef = _firestore.collection('retailers').withConverter<Retailer>(
          fromFirestore: (snapshots, _) => Retailer.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return (await _userRef.doc(rid).get()).data();
  }

  Future<void> updateUser(Delivery userData) async {
    var _userRef = _firestore
        .collection('deliveryboys')
        .withConverter<Delivery>(
          fromFirestore: (snapshots, _) => Delivery.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    await _userRef.doc(userData.did).set(userData);
  }

  // Order Services

  Future<List<Order>> getAllUserOrders(String did) async {
    var _orderRef = _firestore.collection('orders').withConverter<Order>(
          fromFirestore: (snapshots, _) => Order.fromJson(snapshots.data()!),
          toFirestore: (order, _) => order.toJson(),
        );
    List<Order> orderList = [];
    List<QueryDocumentSnapshot<Order>> orders = await _orderRef
        .where('did', isEqualTo: did)
        .get()
        .then((orders) => orders.docs);
    for (var order in orders) {
      orderList.add(order.data());
    }
    return orderList;
  }

  Future<List<Order>> getAcceptedUserOrders(String did) async {
    List<Order> orderList = await getAllUserOrders(did);
    List<Order> acceptedList = [];
    for (var order in orderList) {
      if (order.status == OrderStatus.accepted ||
          order.status == OrderStatus.start) {
        acceptedList.add(order);
      }
    }
    return acceptedList;
  }

  Future<List<Order>> getCompletedUserOrders(String did) async {
    List<Order> orderList = await getAllUserOrders(did);
    List<Order> completedList = [];
    for (var order in orderList) {
      if (order.status == OrderStatus.completed) {
        completedList.add(order);
      }
    }
    return completedList;
  }

  Future<void> updateOrder(Order order) async {
    var _orderRef = _firestore.collection('orders').withConverter<Order>(
          fromFirestore: (snapshots, _) => Order.fromJson(snapshots.data()!),
          toFirestore: (order, _) => order.toJson(),
        );
    await _orderRef.doc(order.oid).set(order);
  }

  //Location Service
  Future<void> updateLocation(DeliveryLocation location) async {
    var _locationRef =
        _firestore.collection('locations').withConverter<DeliveryLocation>(
              fromFirestore: (snapshots, _) =>
                  DeliveryLocation.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    await _locationRef.doc(location.did).set(location);
  }
}
