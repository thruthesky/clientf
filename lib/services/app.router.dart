import 'package:clientf/globals.dart';
import 'package:clientf/pages/home/home.page.dart';
import 'package:clientf/pages/profile/profile.page.dart';
import 'package:clientf/pages/register/register.page.dart';
import 'package:clientf/pages/settings/settings.page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  ///
  /// Opens a page
  /// [nextRoute] is the route to open
  /// [closeDrawer] closes one more route if it's true causing the opened drawer to be closed.
  static Future open(
    context,
    nextRoute, {
    Map<String, dynamic> arguments,
  }) {
    /// If the drawer if opened, then close it.
    if (app.drawer) {
      return Navigator.popAndPushNamed(
        context,
        nextRoute,
        arguments: arguments,
      );
    } else {
      return Navigator.pushNamed(
        context,
        nextRoute,
        arguments: arguments,
      );
    }
  }

  static Route<dynamic> generate(RouteSettings settings) {
    Route route;
    if (settings.name == AppRoutes.home)
      route = _buildRoute(settings, HomePage());
    else if (settings.name == AppRoutes.register)
      route = _buildRoute(settings, RegisterPage());
    else if (settings.name == AppRoutes.profile)
      route = _buildRoute(settings, ProfilePage());
    else if (settings.name == AppRoutes.settings)
      route = _buildRoute(settings, SettingsPage());
    return route;
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
