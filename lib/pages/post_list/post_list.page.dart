import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
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
            onPressed: () {
              open(AppRoutes.postCreate, arguments: {'id': id});
            },
            child: T('Create Post'),
          ),
          if (posts != null) PostListView(posts: posts),
        ],
      ),
    );
  }
}

class PostListView extends StatelessWidget {
  const PostListView({
    Key key,
    @required this.posts,
  }) : super(key: key);

  final List<EnginPost> posts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(posts[i].title ?? 'No title'),
          );
        },
      ),
    );
  }
}
