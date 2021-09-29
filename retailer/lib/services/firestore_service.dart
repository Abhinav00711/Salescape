import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order.dart';
import '../models/product.dart';
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

  // Order Services

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

  //Product Services

  Future<List<Product>> getAllProducts() async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    List<Product> productList = [];
    List<QueryDocumentSnapshot<Product>> products =
        await _productRef.get().then((products) => products.docs);
    for (var product in products) {
      productList.add(product.data());
    }
    return productList;
  }

  Future<List<Product>> getAllProductsByQuery(String query) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    List<Product> productList = [];
    List<QueryDocumentSnapshot<Product>> products =
        await _productRef.get().then((products) => products.docs);
    for (var product in products) {
      var p = product.data();
      if (p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.wname.toLowerCase().contains(query.toLowerCase())) {
        productList.add(p);
      }
    }
    return productList;
  }
}
