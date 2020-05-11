import 'dart:async';

import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  String id;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () {
      var _arg = routerArguments(context);
      setState(() {
        id = _arg['id'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T(id ?? ''),
      ),
      endDrawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                open(AppRoutes.postCreate, arguments: {'id': id});
              },
              child: T('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
