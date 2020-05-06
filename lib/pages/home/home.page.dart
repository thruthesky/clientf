import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
