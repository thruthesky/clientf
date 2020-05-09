import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class CategoryCreatePage extends StatefulWidget {
  @override
  _CategoryCreatePageState createState() => _CategoryCreatePageState();
}

class _CategoryCreatePageState extends State<CategoryCreatePage> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        title: T('setting'),
      ),
      endDrawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                ///
              },
              child: T('Button'),
            ),
          ],
        ),
      ),
    );
  }
}
