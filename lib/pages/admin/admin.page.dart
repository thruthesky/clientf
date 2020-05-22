import 'package:clientf/flutter_engine/engine.defines.dart';
import 'package:clientf/flutter_engine/widgets/engine.text.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';

import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T(ADMIN_PAGE),
      ),
      endDrawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    open(Routes.categoryList);
                  },
                  child: T('Category List'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
