import 'package:cloud_firestore/cloud_firestore.dart';

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
}
