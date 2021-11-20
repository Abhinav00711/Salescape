import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wholesaler.dart';
import '../models/retailer.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/delivery.dart';
import '../models/delivery_location.dart';
import '../models/report.dart';

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

  Future<void> updateDeliveryStatus(Delivery userData) async {
    var _userRef = _firestore
        .collection('deliveryboys')
        .withConverter<Delivery>(
          fromFirestore: (snapshots, _) => Delivery.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    await _userRef.doc(userData.did).set(userData);
  }

  Future<Retailer> getRetailer(String rid) async {
    var _userRef = _firestore.collection('retailers').withConverter<Retailer>(
          fromFirestore: (snapshots, _) => Retailer.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return (await _userRef.doc(rid).get()).data()!;
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

  Future<List<Delivery>> getAllFreeDelivery() async {
    var _userRef = _firestore
        .collection('deliveryboys')
        .withConverter<Delivery>(
          fromFirestore: (snapshots, _) => Delivery.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    List<Delivery> deliveryList = [];
    List<QueryDocumentSnapshot<Delivery>> delivery =
        await _userRef.where('status', isEqualTo: 0).get().then((d) => d.docs);
    for (var del in delivery) {
      deliveryList.add(del.data());
    }
    return deliveryList;
  }

  Stream<DeliveryLocation> getDeliveryLocation(String did) {
    return _firestore
        .collection('locations')
        .doc(did)
        .snapshots()
        .map((snapshot) => DeliveryLocation.fromMap(snapshot.data()!));
  }

  //Product Services

  Future<void> addProduct(Product product) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    await _productRef.doc(product.pid).set(product);
  }

  Future<Product?> getProduct(String pid) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    return (await _productRef.doc(pid).get()).data();
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

  Future<void> deleteProduct(String pid) async {
    var _productRef = _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
    return _productRef
        .doc(pid)
        .delete()
        .then((value) => print("Product Deleted"))
        .catchError((error) => print("Failed to product user: $error"));
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

  Future<void> deleteOrder(String oid) async {
    var _orderRef = _firestore.collection('orders').withConverter<Order>(
          fromFirestore: (snapshots, _) => Order.fromJson(snapshots.data()!),
          toFirestore: (order, _) => order.toJson(),
        );
    return _orderRef
        .doc(oid)
        .delete()
        .then((value) => print("Order Deleted"))
        .catchError((error) => print("Failed to delete order: $error"));
  }

  //Report Service
  Future<Report> getReport(String wid) async {
    int total;
    List<String> pidList = [];
    List<Order> pendingList = [];
    List<Order> acceptedList = [];
    List<Order> completedList = [];
    List<ProductReport> prodrep = [];

    var value = await getAllUserOrders(wid);
    total = value.length;
    for (var order in value) {
      if (order.status == OrderStatus.pending) {
        pendingList.add(order);
      } else if (order.status == OrderStatus.accepted ||
          order.status == OrderStatus.start) {
        acceptedList.add(order);
      } else {
        completedList.add(order);
      }
      for (var item in order.items) {
        if (!pidList.contains(item.pid)) {
          pidList.add(item.pid);
          var prod = await getProduct(item.pid);
          prodrep.add(ProductReport(pid: item.pid, name: prod!.name, qty: 1));
        } else {
          var i = prodrep.lastIndexWhere((e) => e.pid == item.pid);
          prodrep[i].qty = prodrep[i].qty + 1;
        }
      }
    }
    return Report(
        torder: total.toString(),
        pending: pendingList.length,
        accepted: acceptedList.length,
        completed: completedList.length,
        prodrep: prodrep);
  }
}
