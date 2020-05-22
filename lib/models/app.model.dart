import 'package:flutter/material.dart';

/// 앱 모델
///
/// 앱의 전반적인 State 을 담당한다.
/// 하지만, 특정 부분(기능, 또는 특정 부분에서만 쓰이는 기능)에 대한 State 는 따로 관리를 한다. 예) 파일업로드 모델
///
class AppModel extends ChangeNotifier {
  /// 사이드 메뉴가 열렸는지 아닌지 판단
  /// true - open
  /// false - closed
  bool drawer = false;

  AppModel();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Returns the context of [navigatorKey]
  BuildContext get context => navigatorKey.currentState.overlay.context;


  notify() {
    notifyListeners();
  }
}
