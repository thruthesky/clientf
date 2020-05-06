import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  /// State of drawer
  /// true - open
  /// false - closed
  bool drawer = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// If user is null when no user is logged in.
  FirebaseUser user;

  AppModel() {
    print('AppModel() consturctor');
  }
  init() async {
    print('AppModel::init()');
    user = await _auth.currentUser();
    notifyListeners();
  }

  /// Let user log into the Firebase Auth
  /// It notifies & returns user object.
  Future<FirebaseUser> login(String email, String password) async {

      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      if (result.user != null) {
        user = result.user;
      } else {
        user = null;
      }
      notifyListeners();
      return user;
  }

  logout() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
