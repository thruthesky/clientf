import 'package:clientf/globals.dart';
import 'package:clientf/pages/home/home.page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    Route route;

    if (settings.name == AppRoutes.home)
      route = _buildRoute(settings, HomePage());
    else if (settings.name == AppRoutes.register)
      route = _buildRoute(settings, HomePage());

    return route;
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}