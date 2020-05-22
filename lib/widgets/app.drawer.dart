import 'package:clientf/flutter_engine/engine.globals.dart';
import 'package:clientf/flutter_engine/widgets/engine.text.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.defines.dart';

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
              AppRouter.open(context, Routes.home);
            },
          ),
          DrawerDivider(title: t('Member')),
          MenuItem(
            title: t(app.loggedIn ? 'Profile' : 'Register'),
            icon: Icons.person_add,
            onTap: () {
              AppRouter.open(context, Routes.register);
            },
          ),
          if (app.notLoggedIn)
            MenuItem(
              title: t('Login'),
              icon: Icons.arrow_forward,
              onTap: () {
                AppRouter.open(context, Routes.login);
              },
            ),

          if (app.loggedIn)
            MenuItem(
              title: t('Logout'),
              icon: Icons.reply,
              onTap: () async {
                await ef.logout();
                AppRouter.open(context, Routes.home);
              },
            ),
          DrawerDivider(title: t('Forum')),
          MenuItem(
            title: t('discussion'),
            icon: Icons.chat_bubble,
            onTap: () {
              open(Routes.postList, arguments: {'id': 'discussion'});
            },
          ),
          MenuItem(
            title: t('qna'),
            icon: Icons.chat_bubble_outline,
            onTap: () {
              open(Routes.postList, arguments: {'id': 'qna'});
            },
          ),
          MenuItem(
            title: t('새소식'),
            icon: Icons.chat_bubble_outline,
            onTap: () {
              open(Routes.postList, arguments: {'id': 'news'});
            },
          ),
          MenuItem(
            title: t('정보 공유'),
            icon: Icons.chat_bubble_outline,
            onTap: () {
              open(Routes.postList, arguments: {'id': 'share'});
            },
          ),
          DrawerDivider(title: t('Etc')),
          MenuItem(
            title: t('help'),
            icon: Icons.help_outline,
            onTap: () {
              AppRouter.open(context, Routes.help);
            },
          ),
          MenuItem(
            title: t('setting'),
            icon: Icons.settings,
            onTap: () {
              AppRouter.open(context, Routes.settings);
            },
          ),
          if (ef.isAdmin) MenuItem(
            title: t('Admin Dashboard'),
            icon: Icons.settings,
            onTap: () {
              AppRouter.open(context, Routes.admin);
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
