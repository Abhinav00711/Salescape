import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wholesaler.dart';

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
}
