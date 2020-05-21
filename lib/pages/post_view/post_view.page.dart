import 'package:clientf/flutter_engine/engine.comment.model.dart';
import 'package:clientf/flutter_engine/engine.forum.dart';
import 'package:clientf/flutter_engine/engine.globals.dart';
import 'package:clientf/flutter_engine/engine.post.model.dart';
import 'package:clientf/flutter_engine/widgets/engine.post_item.dart';
import 'package:clientf/flutter_engine/widgets/engine.text.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.service.dart';

import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class PostViewPage extends StatefulWidget {
  @override
  _PostViewPageState createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  EngineForum forum = EngineForum();
  @override
  Widget build(BuildContext context) {
    var args = routerArguments(context);
    return Scaffold(
      appBar: AppBar(
        title: T('글 읽기'),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: EnginePostItem(
          args['post'],
          onEdit: (post) async {
            EnginePost updatedPost = await open(AppRoutes.postUpdate,
                arguments: {'post': args['post']});
            forum.updatePost(post, updatedPost);
            setState(() {});
          },
          onReply: (post) async {
            EngineComment comment = await AppService.openCommentBox(
                args['post'], null, EngineComment());
            forum.addComment(comment, post, null);
            setState(() {/** 코멘트 작성 rendering */});
          },
          onDelete: () => AppService.alert(null, t('post deleted')),
          onError: (e) => AppService.alert(null, t(e)),
        ),
      ),
    );
  }
}
