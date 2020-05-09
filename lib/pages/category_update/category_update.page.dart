import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class CategoryUpdatePage extends StatefulWidget {
  @override
  _CategoryUpdatePageState createState() => _CategoryUpdatePageState();
}

class _CategoryUpdatePageState extends State<CategoryUpdatePage> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        title: T('category update'),
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
