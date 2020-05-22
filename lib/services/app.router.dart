import 'package:clientf/globals.dart';
import 'package:clientf/pages/admin/admin.page.dart';
import 'package:clientf/pages/category_create/category_create.page.dart';
import 'package:clientf/pages/category_list/category_list.page.dart';
import 'package:clientf/pages/category_update/category_update.page.dart';
import 'package:clientf/pages/help/help.page.dart';
import 'package:clientf/pages/home/home.page.dart';
import 'package:clientf/pages/login/login.page.dart';
import 'package:clientf/pages/post_edit/post.edit.dart';
import 'package:clientf/pages/post_list/post_list.page.dart';
import 'package:clientf/pages/post_view/post_view.page.dart';
import 'package:clientf/pages/register/register.page.dart';
import 'package:clientf/pages/settings/settings.page.dart';
import 'package:clientf/services/app.defines.dart';
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
    if (settings.name == Routes.home)
      route = _buildRoute(settings, HomePage());
    else if (settings.name == Routes.register)
      route = _buildRoute(settings, RegisterPage());
    else if (settings.name == Routes.login)
      route = _buildRoute(settings, LoginPage());
    else if (settings.name == Routes.help)
      route = _buildRoute(settings, HelpPage());
    else if (settings.name == Routes.settings)
      route = _buildRoute(settings, SettingsPage());
    else if (settings.name == Routes.categoryCreate)
      route = _buildRoute(settings, CategoryCreatePage());
    else if (settings.name == Routes.categoryList)
      route = _buildRoute(settings, CategoryListPage());
    else if (settings.name == Routes.categoryUpdate)
      route = _buildRoute(settings, CategoryUpdatePage());
    else if (settings.name == Routes.postList)
      route = _buildRoute(settings, PostListPage());
    else if (settings.name == Routes.postCreate)
      route = _buildRoute(settings, PostEditPage());
    else if (settings.name == Routes.postView)
      route = _buildRoute(settings, PostViewPage());
    else if (settings.name == Routes.admin)
      route = _buildRoute(settings, AdminPage());
    return route;
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
