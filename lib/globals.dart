import './flutter_engine/engine.model.dart';
import 'package:clientf/models/app.model.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';

import 'dart:math';


/// 전체 앱 state 를 관리하는 모델.
/// 
/// 글로벌 영역에서 instance 를 생성하고, 전체 앱에서 공유를 한다.
AppModel app = AppModel();



Future open(String route, {arguments}) {
  return AppRouter.open(AppService.context, route, arguments: arguments);
}

back({arguments}) {
  Navigator.pop(AppService.context, arguments);
}

dynamic routerArguments(context) {
  return ModalRoute.of(context).settings.arguments;
}


// String touchId() {
//   return 'touch-id-' + randomString();
// }
