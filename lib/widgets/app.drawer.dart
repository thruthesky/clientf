import 'package:clientf/globals.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.keys.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.space.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({this.select});
  final String select;
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool showWordListMenus = false;

  @override
  void initState() {
    // print('_AppDrawerState::initState');
    app.drawer = true;
    super.initState();
  }

  @override
  void dispose() {
    // print('_AppDrawerState::dispose');
    app.drawer = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: Key(AppKey.drawer),
      child: ListView(
        padding: EdgeInsets.only(bottom: AppSpace.space),
        children: <Widget>[
          Container(
            height: 100,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(top: 20, left: 12),
              decoration: BoxDecoration(color: AppColor.primaryColor),
              child: T(
                'appName',
                style: TextStyle(color: AppColor.white, fontSize: 18),
              ),
            ),
          ),
          MenuItem(
            title: t('home'),
            icon: Icons.home,
            onTap: () {
              AppRouter.open(context, AppRoutes.home);
            },
          ),
          DrawerDivider(title: t('Member')),
          MenuItem(
            title: t('Register'),
            icon: Icons.person_add,
            onTap: () {
              AppRouter.open(context, AppRoutes.register);
            },
          ),
          MenuItem(
            title: t('Login'),
            icon: Icons.arrow_forward,
            onTap: () {
              AppRouter.open(context, AppRoutes.login);
            },
          ),
          MenuItem(
            title: t('Profile'),
            icon: Icons.person,
            onTap: () {
              AppRouter.open(context, AppRoutes.profile);
            },
          ),
          MenuItem(
            title: t('Logout'),
            icon: Icons.reply,
            onTap: () async {
              await app.f.logout();
              AppRouter.open(context, AppRoutes.home);
            },
          ),
          DrawerDivider(title: t('Etc')),
          MenuItem(
            title: t('help'),
            icon: Icons.help_outline,
            onTap: () {
              AppRouter.open(context, AppRoutes.help);
            },
          ),
          MenuItem(
            title: t('setting'),
            icon: Icons.settings,
            onTap: () {
              AppRouter.open(context, AppRoutes.settings);
            },
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key key,
    @required this.title,
    @required this.onTap,
    this.icon,
    this.isSelected,
    this.paddingLeft,
    this.fontSize = 16.0,
    // this.isDense = false,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected;
  // final bool isDense;
  final double paddingLeft;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, size: 25.0, color: Colors.black),
        title: Text(
          title,
          style: TextStyle(fontSize: fontSize, color: Colors.black),
        ),
        onTap: onTap,
      ),
    );
  }
}

class DrawerDivider extends StatelessWidget {
  DrawerDivider(
      {@required this.title,
      this.padding =
          const EdgeInsets.only(top: 26.0, left: 18.0, bottom: 4.0)});

  final String title;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: padding,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
