import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/pages/post_list/post_list_view.dart';
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
  List<EnginPost> posts;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () async {
      var _arg = routerArguments(context);
      setState(() {
        id = _arg['id'];
      });

      final _re = await app.f.postList({
        'categories': [_arg['id']]
      });
      print(_re);
      setState(() {
        posts = _re;
      });
      print(_re.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T(id ?? ''),
      ),
      endDrawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              final EnginPost post =
                  await open(AppRoutes.postCreate, arguments: {'id': id});

              /// TODO: update list after getting newly create post data.
              print('/// TODO: update list after getting newly create post data.');
              print(post);
            },
            child: T('Create Post'),
          ),
          if (posts != null) PostListView(posts: posts),
        ],
      ),
    );
  }
}
