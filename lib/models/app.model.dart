import 'package:clientf/enginf_clientf_service/enginf.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  /// State of drawer
  /// true - open
  /// false - closed
  bool drawer = false;

  final EngineModel f = EngineModel();

  AppModel() {
    print('AppModel() consturctor');
  }

  init() async {
    print('AppModel::init()');
    notifyListeners();
  }

  Future<FirebaseUser> login(String email, String password) async {
    final user = await f.login(email, password);
    notifyListeners();
    return user;
  }
}
