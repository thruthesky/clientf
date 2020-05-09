import 'package:clientf/models/app.model.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';

AppModel app = AppModel();

open(String route) {
  AppRouter.open(AppService.context, route);
}
