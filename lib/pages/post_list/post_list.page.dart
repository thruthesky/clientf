import 'dart:async';

import 'package:clientf/flutter_engine/engine.comment.model.dart';
import 'package:clientf/flutter_engine/engine.globals.dart';
import 'package:clientf/flutter_engine/widgets/engine.app_bar.dart';
import 'package:clientf/flutter_engine/widgets/engine.comment_box.dart';
import 'package:clientf/flutter_engine/widgets/engine.post_create_action_button.dart';
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
      // forum.initScrollListener();
      forum.loadPage(
        id: _arg['id'],
        onLoad: () {
          // print('post loaded');
          // print(forum.posts);
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

        actions: PostCreateActionButton(forum.id, () async {
          final EnginePost post =
              await open(AppRoutes.postCreate, arguments: {'id': forum.id});
          forum.addPost(post);

          /// TODO: 글 쓴 후, 최 상위로 스크롤 업 할 것. 목록 중간에 스크롤이 된 경우, 맨 위에 글을 바로 볼 수 없다.
          setState(() {/** 새글 반영 */});
        }),

        // actions: GestureDetector(
        //   child: Icon(Icons.add),
        //   onTap: () async {
        //     final EnginePost post =
        //         await open(AppRoutes.postCreate, arguments: {'id': forum.id});

        //     if (post != null) {
        //       setState(() {
        //         /// TODO: 스크롤 업. forum 클래스에서 post 를 처음에 추가하고 ScrollController 로 스크롤업 하면 좋겠다.
        //         forum.posts.insert(0, post);
        //       });
        //     }
        //   },
        // ),
        
        onTapUserPhoto: () =>
            open(ef.loggedIn ? AppRoutes.register : AppRoutes.login),
      ),
      endDrawer: AppDrawer(),
      body: EnginePostList(
        forum,
        onUpdate: (EnginePost post) async {
          /// 글 수정
          var updatedPost =
              await open(AppRoutes.postUpdate, arguments: {'post': post});
          forum.updatePost(post, updatedPost);
          setState(() {/** 수정된 글 Re-rendering */});
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
          // print('==> commnetupdate: ');
          // print(comment);
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
    );
  }
}
