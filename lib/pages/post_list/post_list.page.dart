import 'dart:async';
import 'package:clientf/flutter_engine/engine.forum_list.model.dart';
import 'package:clientf/flutter_engine/widgets/forum/engine.post_view.dart';
import 'package:clientf/widgets/app.padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../flutter_engine/engine.globals.dart';
import '../../flutter_engine/widgets/engine.app_bar.dart';
import '../../flutter_engine/widgets/engine.post_create_action_button.dart';

import '../../flutter_engine/engine.post.model.dart';
import '../../globals.dart';
import '../../services/app.defines.dart';

import '../../widgets/app.drawer.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  // EngineForum forum = EngineForum();

  EngineForumListModel forum = EngineForumListModel();

  @override
  void initState() {
    Timer(Duration(milliseconds: 100), () {
      var _args = routerArguments(context);
      forum.init(
        id: _args['id'],
        cacheKey: _args['id'],
        limit: 5,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    forum.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => forum),
      ],
      child: Scaffold(
        appBar: EngineAppBar(
          title: t(forum.id ?? ''),
          actions: PostCreateActionButton(() async {
            final EnginePost post = await open(
              Routes.postCreate,
              arguments: {'id': forum.id},
            );
            forum.addPost(post);
          }),
          onTapUserPhoto: () =>
              open(ef.loggedIn ? Routes.register : Routes.login),
        ),
        endDrawer: AppDrawer(),
        body: AppPadding(
          child: Consumer<EngineForumListModel>(
            builder: (context, model, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: model.posts.length,
                controller: forum.scrollController,
                itemBuilder: (context, i) {
                  return EnginePostView(model.posts[i]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
