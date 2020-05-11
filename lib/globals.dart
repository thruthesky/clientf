import 'package:clientf/models/app.model.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';

AppModel app = AppModel();

open(String route, {arguments}) {
  AppRouter.open(AppService.context, route, arguments: arguments);
}

back() {
  Navigator.pop(AppService.context);
}

dynamic routerArguments(context) {
  return ModalRoute.of(context).settings.arguments;
}
