import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wholesaler.dart';
import '../models/product.dart';

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
}
