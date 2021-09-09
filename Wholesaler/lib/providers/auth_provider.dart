import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user;
  User? get getUser => _user;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> register(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = authResult.user;
      setLoading(false);
      notifyListeners();
      return _user != null ? null : 'An error Occurred';
    } on SocketException {
      setLoading(false);
      notifyListeners();
      return "No internet, please connect to internet";
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      notifyListeners();
      return e.message;
    }
  }

  Future<String?> login(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = authResult.user;
      setLoading(false);
      notifyListeners();
      return _user != null ? null : 'An error Occurred';
    } on SocketException {
      setLoading(false);
      notifyListeners();
      return "No internet, please connect to internet";
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      notifyListeners();
      return e.message;
    }
  }

  Future logout() async {
    _user = null;
    await firebaseAuth.signOut();
  }

  Future<bool> isVerified() async {
    await firebaseAuth.currentUser!.reload();
    return firebaseAuth.currentUser!.emailVerified;
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  Stream<User?> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
