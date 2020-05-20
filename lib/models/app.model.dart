
import 'package:clientf/flutter_engine/engine.globals.dart';
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

  bool online = false;


  /// @deprecated 이 변수를 사용하지 말고, 글로벌 `ef` 변수를 바로 사용 할 것.
  bool get loggedIn => ef.loggedIn;
  bool get notLoggedIn => ef.notLoggedIn;

  AppModel() {
    // print('AppModel() consturctor');
  }

  init() async {
    // print('AppModel::init()');
    notifyListeners();
  }

  // Future<FirebaseUser> login(String email, String password) async {
  //   final user = await f.login(email, password);
  //   notifyListeners();
  //   return user;
  // }
}
