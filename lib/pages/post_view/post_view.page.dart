import 'package:clientf/flutter_engine/engine.comment.model.dart';
import 'package:clientf/flutter_engine/engine.forum.dart';
import 'package:clientf/flutter_engine/engine.globals.dart';
import 'package:clientf/flutter_engine/engine.post.model.dart';
import 'package:clientf/flutter_engine/widgets/engine.comment_box.dart';
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
          onUpdate: (post) async {
            EnginePost updatedPost = await open(Routes.postUpdate,
                arguments: {'post': args['post']});
            forum.updatePost(post, updatedPost);
            setState(() {});
          },
          onReply: (EnginePost post) async {
            /// 글에서 Reply 버튼을 클릭한 경우
            var reply = AppService.openDialog(EngineCommentBox(
              post,
              currentComment: EngineComment(),
              onCommentReply: (EngineComment comment) {
                forum.addComment(comment, post, null);
                setState(() {/** 댓글 반영 */});
                back(arguments: comment);
              },
              onCommentError: (e) => AppService.alert(null, t(e)),
            ));
          },
          onDelete: () => AppService.alert(null, t('post deleted')),
          onError: (e) => AppService.alert(null, t(e)),

          onCommentReply: (EnginePost post, EngineComment parentComment) async {
            /// 코멘트에서 Reply 버튼을 클릭한 경우,
            var reply = AppService.openDialog(EngineCommentBox(
              post,
              currentComment: EngineComment(),
              parentComment: parentComment,
              onCommentReply: (EngineComment comment) {
                forum.addComment(comment, post, parentComment.id);
                setState(() {/** 댓글 반영 */});
                back(arguments: comment);
              },
              onCommentError: (e) => AppService.alert(null, t(e)),
            ));
          },
          onCommentUpdate: (EnginePost post, EngineComment comment) {
            var reply = AppService.openDialog(EngineCommentBox(
              post,
              currentComment: comment,
              onCommentUpdate: (EngineComment comment) {
                forum.updateComment(comment, post);
                setState(() {/** 댓글 반영 */});
                back(arguments: comment);
              },
              onCommentError: (e) => AppService.alert(null, t(e)),
            ));
          },
          onCommentDelete: () {},
          onCommentError: (e) => AppService.alert(null, t(e)),
        ),
      ),
    );
  }
}
