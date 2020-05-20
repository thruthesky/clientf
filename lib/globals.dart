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

/// EngineF state
EngineModel ef = EngineModel();



Future open(String route, {arguments}) {
  return AppRouter.open(AppService.context, route, arguments: arguments);
}

back({arguments}) {
  Navigator.pop(AppService.context, arguments);
}

dynamic routerArguments(context) {
  return ModalRoute.of(context).settings.arguments;
}

/// 랜덤 문자열을 리턴한다.
///
/// [length] 리턴 받을 랜덤 문자열의 길이를 정 할 수 있다.
String randomString({int length = 24}) {
  var rand = new Random();
  var codeUnits = new List.generate(length, (index) {
    return rand.nextInt(33) + 89;
  });

  return new String.fromCharCodes(codeUnits);
}

// String touchId() {
//   return 'touch-id-' + randomString();
// }
