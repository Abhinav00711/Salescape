import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/delivery.dart';

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

  // Order Services

}
