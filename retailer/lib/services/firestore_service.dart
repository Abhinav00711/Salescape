import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order.dart';
import '../models/product.dart';
import '../models/retailer.dart';
import '../models/wholesaler.dart';
import '../models/delivery.dart';
import '../models/delivery_location.dart';

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
    var _userRef = _firestore.collection('retailers').withConverter<Retailer>(
          fromFirestore: (snapshots, _) => Retailer.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    await _userRef.doc(userData.rid).set(userData);
  }

  Future<String?> getWholesalerState(String wid) async {
    var _userRef =
        _firestore.collection('wholesalers').withConverter<Wholesaler>(
              fromFirestore: (snapshots, _) =>
                  Wholesaler.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    return (await _userRef.doc(wid).get()).data()!.state;
  }

  Future<String> getWholesalerBname(String wid) async {
    var _userRef =
        _firestore.collection('wholesalers').withConverter<Wholesaler>(
              fromFirestore: (snapshots, _) =>
                  Wholesaler.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    return (await _userRef.doc(wid).get()).data()!.bname;
  }

  Future<Delivery?> getDelivery(String did) async {
    var _userRef = _firestore
        .collection('deliveryboys')
        .withConverter<Delivery>(
          fromFirestore: (snapshots, _) => Delivery.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return (await _userRef.doc(did).get()).data();
  }

  Stream<DeliveryLocation> getDeliveryLocation(String did) {
    return _firestore
        .collection('locations')
        .doc(did)
        .snapshots()
        .map((snapshot) => DeliveryLocation.fromMap(snapshot.data()!));
  }

  // Order Services

  Future<void> addOrder(Order order) async {
    var _orderRef = _firestore.collection('orders').withConverter<Order>(
          fromFirestore: (snapshots, _) => Order.fromJson(snapshots.data()!),
          toFirestore: (order, _) => order.toJson(),
        );
    await _orderRef.doc(order.oid).set(order);
  }

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
      if (order.status == OrderStatus.accepted ||
          order.status == OrderStatus.start) {
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

  Future<Product?> getProduct(String pid) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    return (await _productRef.doc(pid).get()).data();
  }

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
          p.bname.toLowerCase().contains(query.toLowerCase())) {
        productList.add(p);
      }
    }
    return productList;
  }

  Future<List<Product>> getAllIndustryProductsByQuery(
      String query, String industry) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    List<Product> productList = [];
    List<QueryDocumentSnapshot<Product>> products =
        await _productRef.get().then((products) => products.docs);
    for (var product in products) {
      var p = product.data();
      if ((p.industry == industry) &&
          (p.name.toLowerCase().contains(query.toLowerCase()) ||
              p.bname.toLowerCase().contains(query.toLowerCase()))) {
        productList.add(p);
      }
    }
    return productList;
  }
}
