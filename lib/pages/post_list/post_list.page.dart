import 'dart:async';

import 'package:clientf/flutter_engine/engine.globals.dart';
import 'package:clientf/flutter_engine/widgets/engine.app_bar.dart';
import 'package:clientf/flutter_engine/widgets/engine.post_list.dart';
import 'package:clientf/services/app.service.dart';

import '../../flutter_engine/engine.forum.dart';
import '../../flutter_engine/engine.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';

import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  EngineForum forum = EngineForum();

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () async {
      var _arg = routerArguments(context);

      // forum.id = _arg['id'];
      forum.initScrollListener();
      forum.loadPage(
        id: _arg['id'],
        onLoad: () {
          print('post loaded');
          print(forum.posts);
          setState(() {
            /** posts loaded */
          });
        },
        onError: (e) => AppService.alert(null, t(e)),
        cacheKey: 'forum-list-${_arg['id']}',
      );

      // forum.init(id: _arg['id']);

// forum.loadPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EngineAppBar(
        title: t(forum.id ?? ''),
        actions: GestureDetector(
          child: Icon(Icons.add),
          onTap: () async {
            final EnginePost post =
                await open(AppRoutes.postCreate, arguments: {'id': forum.id});

            if (post != null) {
              setState(() {
                /// TODO: 스크롤 업. forum 클래스에서 post 를 처음에 추가하고 ScrollController 로 스크롤업 하면 좋겠다.
                forum.posts.insert(0, post);
              });
            }
          },
        ),
        onTapUserPhoto: () =>
            open(ef.loggedIn ? AppRoutes.register : AppRoutes.login),
      ),
      endDrawer: AppDrawer(),
      body: EnginePostList(
        forum,
        onEdit: (post) async {
          var updatedPost =
              await open(AppRoutes.postUpdate, arguments: {'post': post});
          forum.updatePost(post, updatedPost);
          setState(() {/** 수정된 글 Re-rendering */});
        },
      ),
    );
  }
}
