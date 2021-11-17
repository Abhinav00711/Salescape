import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wholesaler.dart';
import '../models/retailer.dart';
import '../models/product.dart';
import '../models/order.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  // User Services

  Future<void> addUser(Wholesaler userData) async {
    var _userRef =
        _firestore.collection('wholesalers').withConverter<Wholesaler>(
              fromFirestore: (snapshots, _) =>
                  Wholesaler.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    await _userRef.doc(userData.wid).set(userData);
  }

  Future<Wholesaler?> getUser(String wid) async {
    var _userRef =
        _firestore.collection('wholesalers').withConverter<Wholesaler>(
              fromFirestore: (snapshots, _) =>
                  Wholesaler.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    return (await _userRef.doc(wid).get()).data();
  }

  Future<void> updateUser(Wholesaler userData) async {
    var _userRef =
        _firestore.collection('wholesalers').withConverter<Wholesaler>(
              fromFirestore: (snapshots, _) =>
                  Wholesaler.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    await _userRef.doc(userData.wid).set(userData);
  }

  Future<Retailer> getRetailer(String rid) async {
    var _userRef = _firestore.collection('retailers').withConverter<Retailer>(
          fromFirestore: (snapshots, _) => Retailer.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return (await _userRef.doc(rid).get()).data()!;
  }

  //Product Services

  Future<void> addProduct(Product product) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    await _productRef.doc(product.pid).set(product);
  }

  Future<List<Product>> getAllProducts(String wid) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    List<Product> productList = [];
    List<QueryDocumentSnapshot<Product>> products = await _productRef
        .where('wid', isEqualTo: wid)
        .get()
        .then((products) => products.docs);
    for (var product in products) {
      productList.add(product.data());
    }
    return productList;
  }

  Future<void> deleteProduct(Product product, String pid) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    return _productRef
        .doc(pid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  // Order Services

  Future<List<Order>> getAllUserOrders(String wid) async {
    var _orderRef = _firestore.collection('orders').withConverter<Order>(
          fromFirestore: (snapshots, _) => Order.fromJson(snapshots.data()!),
          toFirestore: (order, _) => order.toJson(),
        );
    List<Order> orderList = [];
    List<QueryDocumentSnapshot<Order>> orders = await _orderRef
        .where('wid', isEqualTo: wid)
        .get()
        .then((orders) => orders.docs);
    for (var order in orders) {
      orderList.add(order.data());
    }
    return orderList;
  }

  Future<List<Order>> getPendingUserOrders(String wid) async {
    List<Order> orderList = await getAllUserOrders(wid);
    List<Order> pendingList = [];
    for (var order in orderList) {
      if (order.status == OrderStatus.pending) {
        pendingList.add(order);
      }
    }
    return pendingList;
  }

  Future<List<Order>> getAcceptedUserOrders(String wid) async {
    List<Order> orderList = await getAllUserOrders(wid);
    List<Order> acceptedList = [];
    for (var order in orderList) {
      if (order.status == OrderStatus.accepted ||
          order.status == OrderStatus.start) {
        acceptedList.add(order);
      }
    }
    return acceptedList;
  }

  Future<List<Order>> getCompletedUserOrders(String wid) async {
    List<Order> orderList = await getAllUserOrders(wid);
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
}
