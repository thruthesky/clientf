import 'package:flutter/material.dart';
import './models/app.model.dart';
import './services/app.router.dart';

/// 전체 앱 State 를 관리
///
/// 글로벌 영역에서 instance 를 생성하고, 전체 앱에서 공유를 한다.
AppModel app = AppModel();


/// TODO: Move it to `engine globals`.
Future open(String route, {arguments}) {
  return AppRouter.open(app.context, route, arguments: arguments);
}

///
void back({arguments}) {
  Navigator.pop(app.context, arguments);
}

Map<dynamic, dynamic> routerArguments(context) {
  return ModalRoute.of(context).settings.arguments;
}
