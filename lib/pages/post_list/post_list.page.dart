import 'dart:async';
import 'package:clientf/widgets/app.padding.dart';
import 'package:flutter/material.dart';

import '../../flutter_engine/engine.comment.model.dart';
import '../../flutter_engine/engine.globals.dart';
import '../../flutter_engine/widgets/engine.app_bar.dart';
import '../../flutter_engine/widgets/engine.comment_box.dart';
import '../../flutter_engine/widgets/engine.post_create_action_button.dart';
import '../../flutter_engine/widgets/engine.post_list.dart';

import '../../flutter_engine/engine.forum.dart';
import '../../flutter_engine/engine.post.model.dart';
import '../../globals.dart';
import '../../services/app.defines.dart';

import '../../widgets/app.drawer.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  EngineForum forum = EngineForum();

  @override
  void initState() {
    super.initState();

    loadPage();
  }

  loadPage() {
    Timer(Duration(milliseconds: 10), () async {
      var _arg = routerArguments(context);
      print('=> going to load ${_arg['id']}');
      forum.loadPage(
        id: _arg['id'],
        onLoad: () {
          print('==> got post list ${_arg['id']}');
          // back();
          if (!mounted) return;
          // loadPage();
          setState(() {/** posts loaded */});
        },
        onError: alert,
        cacheKey: 'forum-list-${_arg['id']}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EngineAppBar(
        title: t(forum.id ?? ''),
        actions: PostCreateActionButton(forum.id, () async {
          final EnginePost post =
              await open(Routes.postCreate, arguments: {'id': forum.id});
          forum.addPost(post);
          forum.scrollController.jumpTo(0);
          setState(() {/** 새글 반영 */});
        }),
        onTapUserPhoto: () =>
            open(ef.loggedIn ? Routes.register : Routes.login),
      ),
      endDrawer: AppDrawer(),
      body: AppPadding(
        child: EnginePostList(
          /// Forum Model 을 공유하기 위해서 자식으로 전달
          forum,
          onUpdate: (EnginePost post) async {
            /// 글 수정
            var updatedPost =
                await open(Routes.postUpdate, arguments: {'post': post});
            forum.updatePost(post, updatedPost);
            setState(() {/** 수정된 글 Re-rendering */});
          },
          onReply: (EnginePost post) async {
            /// 글에서 Reply 버튼을 클릭한 경우
            var reply = openDialog(EngineCommentBox(
              post,
              currentComment: EngineComment(),
              onCommentReply: (EngineComment comment) {
                forum.addComment(comment, post, null);
                setState(() {/** 댓글 반영 */});
                back(arguments: comment);
              },
              onCommentError: alert,
            ));
          },
          onDelete: () => alert(t('post deleted')),
          onError: alert,
          onCommentReply: (EnginePost post, EngineComment parentComment) async {
            /// 코멘트에서 Reply 버튼을 클릭한 경우,
            var reply = openDialog(EngineCommentBox(
              post,
              currentComment: EngineComment(),
              parentComment: parentComment,
              onCommentReply: (EngineComment comment) {
                forum.addComment(comment, post, parentComment.id);
                setState(() {/** 댓글 반영 */});
                back(arguments: comment);
              },
              onCommentError: alert,
            ));
          },
          onCommentUpdate: (EnginePost post, EngineComment comment) {
            // print('==> commnetupdate: ');
            // print(comment);
            var reply = openDialog(EngineCommentBox(
              post,
              currentComment: comment,
              onCommentUpdate: (EngineComment comment) {
                forum.updateComment(comment, post);
                setState(() {/** 댓글 반영 */});
                back(arguments: comment);
              },
              onCommentError: alert,
            ));
          },
          onCommentDelete: () {},
          onCommentError: alert,
        ),
      ),
    );
  }
}
