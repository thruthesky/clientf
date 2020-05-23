
import 'package:flutter/material.dart';
import '../../services/app.defines.dart';
import '../../flutter_engine/engine.defines.dart';
import '../../flutter_engine/widgets/engine.text.dart';
import '../../globals.dart';
import '../../widgets/app.drawer.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}
