import 'package:clientf/models/app.model.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('appName'),
      ),
      endDrawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            T('app subtitle'),
            RaisedButton(
              onPressed: () {
                AppRouter.open(context, AppRoutes.register);
              },
              child: T('Register'),
            ),
            RaisedButton(
              onPressed: () {
                AppRouter.open(context, AppRoutes.login);
              },
              child: T('Login'),
            ),
            RaisedButton(
              onPressed: () {
                AppRouter.open(context, AppRoutes.profile);
              },
              child: T('Profile'),
            ),
            Selector<AppModel, FirebaseUser>(
                builder: (context, user, child) {
                  if (user == null) return SizedBox.shrink();
                  print('phoneNumber: ${user.phoneNumber}');
                  print('displayName: ${user.displayName}');
                  return Column(
                    children: <Widget>[
                      Text('user login: ${user.email}'),
                      Text('phoneNumber: ${user.phoneNumber}'),
                      Text('displayName: ${user.displayName}'),
                    ],
                  );
                },
                selector: (_, model) => model.user),
          ],
        ),
      ),
    );
  }
}
