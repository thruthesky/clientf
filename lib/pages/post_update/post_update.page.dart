import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class PostUpdatePage extends StatefulWidget {
  @override
  _PostUpdatePageState createState() => _PostUpdatePageState();
}

class _PostUpdatePageState extends State<PostUpdatePage> {
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
