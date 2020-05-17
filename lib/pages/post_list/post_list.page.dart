import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.forum.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/models/firestore.model.dart';
import 'package:clientf/pages/post_list/widgets/post_list.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  EngineForumModel forumModel = EngineForumModel();

  @override
  void dispose() {
    forumModel.disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () {
      var _arg = routerArguments(context);
      forumModel.init(id: _arg['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => forumModel),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: t(forumModel.id ?? ''),
          actions: GestureDetector(
            child: Icon(Icons.add),
            onTap: () async {
              final EnginePost post =

                  /// create
                  await open(AppRoutes.postCreate,
                      arguments: {'id': forumModel.id});

              if (post != null) {
                setState(() {
                  forumModel.posts.insert(0, post);
                });
              }
            },
          ),
        ),
        endDrawer: AppDrawer(),
        body: forumModel.posts != null
            ? Consumer<EngineForumModel>(builder: (context, model, child) {
                return PostList(
                    posts: forumModel.posts,
                    controller: forumModel.scrollController);
              })
            : SizedBox.shrink(),
      ),
    );
  }
}
