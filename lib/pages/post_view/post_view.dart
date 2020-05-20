import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/engine/post_item.dart';
import 'package:flutter/material.dart';

class PostViewPage extends StatefulWidget {
  @override
  _PostViewPageState createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  @override
  Widget build(BuildContext context) {
    var args = routerArguments(context);
    return Scaffold(
      appBar: AppBar(
        title: T('글 읽기'),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: PostItem(
          args['post'],
        ),
      ),
    );
  }
}
