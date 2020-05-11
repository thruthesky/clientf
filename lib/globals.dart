import 'package:clientf/models/app.model.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';

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
