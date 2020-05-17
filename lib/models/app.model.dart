import 'package:clientf/enginf_clientf_service/enginf.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// 앱 모델
/// 
/// 앱의 전반적인 State 을 담당한다.
/// 하지만, 특정 부분(기능, 또는 특정 부분에서만 쓰이는 기능)에 대한 State 는 따로 관리를 한다. 예) 파일업로드 모델
class AppModel extends ChangeNotifier {
  /// State of drawer
  /// true - open
  /// false - closed
  bool drawer = false;

  final EngineModel f = EngineModel();

  AppModel() {
    // print('AppModel() consturctor');
  }

  init() async {
    // print('AppModel::init()');
    notifyListeners();
  }

  Future<FirebaseUser> login(String email, String password) async {
    final user = await f.login(email, password);
    notifyListeners();
    return user;
  }
}
