import 'dart:io';
import 'package:clientf/services/app.i18n.dart';
import 'package:flutter/material.dart';

/// `CustomAppBar` Widget
///
/// [title] is an empty string by default.
///
/// [elevation] is the z-index of the appbar.
///   if not specified and if the current platform is `IOS` it will automatically be set to `0.0`, and `1.0` for `Android`.
///
/// [centerTitle] is `true` by default. if [actions] is specified it will be automatically set to `false`.
///
/// [actions] can accept any widget, it is preferabble to use button widgets.
///   if this is specified and the current scaffold which this `CustomAppBar` widget belongs to have an `endDrawer`
///   it will show an internal `Menu` Button to open the drawer.
///
/// [backgroundColor] is for the app bar color.
///
/// [automaticallyImplyLeading] is `true` by default, if set to `false`, it will not display the back button when navigating.
///
///
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({
    this.title = '',
    this.elevation,
    this.centerTitle = true,
    this.actions,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
    this.onPressedCreatePostButton,
  });

  final String title;
  final bool centerTitle;
  final double elevation;
  final Widget actions;
  final Color backgroundColor;
  final bool automaticallyImplyLeading;
  final Function onPressedCreatePostButton;

  _openAppDrawer(ScaffoldState scaffold) {
    if (scaffold.hasDrawer) {
      scaffold.openDrawer();
    } else if (scaffold.hasEndDrawer) {
      scaffold.openEndDrawer();
    } else {
      /// do nothing ...
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return AppBar(
        title: Text(title),
        centerTitle: actions == null ? centerTitle : false,
        automaticallyImplyLeading: automaticallyImplyLeading,
        elevation: elevation == null ? Platform.isIOS ? 0.0 : 1.0 : elevation,
        backgroundColor: backgroundColor,
        actions: actions != null
            ? <Widget>[
                actions,
                AppTitleMenuIcon(
                  visible: scaffold.hasEndDrawer,
                  onTap: () => _openAppDrawer(scaffold),
                )
              ]
            : <Widget>[
                AppTitleMenuIcon(
                  visible: scaffold.hasEndDrawer,
                  onTap: () => _openAppDrawer(scaffold),
                )
              ]);
  }
}

class AppTitleMenuIcon extends StatelessWidget {
  AppTitleMenuIcon({this.visible, this.onTap});

  final bool visible;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      child: Visibility(
        visible: visible,
        child: FlatButton(
          child: Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
            // key: Key(AppService.key.drawerOpen),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
