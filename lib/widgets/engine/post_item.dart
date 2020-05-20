import 'package:clientf/flutter_engine/engine.globals.dart';

import '../../flutter_engine/engine.comment.model.dart';
import '../../flutter_engine/engine.forum.dart';
import '../../flutter_engine/engine.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/pages/post_list/widgets/comment_box.dart';
import 'package:clientf/pages/post_list/widgets/comment_list.dart';
import 'package:clientf/services/app.defines.dart';

import 'package:clientf/services/app.service.dart';
import 'package:clientf/widgets/engine/display_uploaded_images.dart';
import 'package:flutter/material.dart';

/// 글을 보여주고 수정/삭제/코멘트 등의 작업을 할 수 있다.
///
/// 다만, 새글을 추가하지는 않는다. 따라서 글 목록 자체는 필요 없이 글 하나의 정보만 필요하다.
class PostItem extends StatefulWidget {
  PostItem(
    this.post, {
    Key key,
  }) : super(key: key);

  final EnginePost post;

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool showContent = true;
  bool showCommentBox = false;

  @override
  void initState() {
    // print('--> _PostItemState::initState() called for: ${widget.post.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EnginePost post = widget.post;
    EngineForum forum = EngineForum();
    if (showContent) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: PostItemContent(post), // 글 제목 & 내용 & 사진 & 기타 정보
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('Reply'),
                onPressed: () async {
                  final re = await AppService.openCommentBox(
                      post, null, EngineComment());
                  forum.addComment(re, post, null);
                  setState(() {
                    /** 수정 반영 */
                  });
                },
              ),
              RaisedButton(
                child: Text('Edit'),
                onPressed: () async {
                  /// 글 수정
                  final EnginePost updatedPost = await open(
                      AppRoutes.postUpdate,
                      arguments: {'post': post});
                  print(updatedPost);
                  forum.updatePost(post, updatedPost);
                  setState(() {
                    /** 글 수정 반영 */
                  });
                },
              ),
              RaisedButton(
                onPressed: () async {
                  AppService.confirm(
                    title: 'confirm',
                    content: 'do you want to delete?',
                    onYes: () async {
                      try {
                        final re = await ef.postDelete(post.id);
                        setState(() {
                          post.title = re.title;
                          post.content = re.content;
                        });
                        print(re);
                        if (re.deletedAt is int) {
                          AppService.alert(null, t('post deleted'));
                        }
                      } catch (e) {}
                    },
                    onNo: () {
                      // print('no');
                    },
                  );
                },
                child: Text('Delete'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    showContent = false;
                  });
                },
                child: Text('Close'),
              ),
            ],
          ),
          if (showCommentBox)
            CommentBox(
              post,
              // onCancel: () => setState(() => showCommentBox = false),
              onSubmit: () => setState(() => showCommentBox = false),
              key: ValueKey('PostItem::CommentBox::' + post.id),
            ),
          CommentList(
            post,
            key: ValueKey('ColumnList${post.id}'),
          )
        ],
      );
    } else {
      return ListTile(
        title: Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),

          /// This padding is for testing.
          child: Text(post.title ?? 'No title'),
        ),
        trailing: Icon(Icons.keyboard_arrow_down),
        onTap: () {
          setState(() {
            showContent = true;
          });
        },
      );
    }
  }
}

class PostItemContent extends StatelessWidget {
  const PostItemContent(
    this.post, {
    Key key,
  }) : super(key: key);

  final EnginePost post;

  @override
  Widget build(BuildContext context) {
    // print('postItem content: $post');
    return Column(
      children: <Widget>[
        Text(
          'title: ${post.title}',
          style: TextStyle(fontSize: 32),
        ),
        Text('author: ${post.uid}'),
        Text('created: ${post.createdAt}'),
        Text('content: ${post.content}'),
        DisplayUploadedImages(
          post,
        ),
      ],
    );
  }
}
