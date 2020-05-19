import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.forum.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/pages/post_list/widgets/post_list.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  EngineForumList forum = EngineForumList();

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () async {
      var _arg = routerArguments(context);

      forum.id = _arg['id'];
      forum.initScrollListener();
      forum.loadPage(onLoad: () {
        print('post loaded');
        setState(() {
          /** posts loaded */
        });
      });

      // forum.init(id: _arg['id']);

// forum.loadPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
      ),
      endDrawer: AppDrawer(),
      body: PostList(forum),
    );
  }
}
