import 'package:clientf/enginf_clientf_service/enginf.forum.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/pages/post_list/widgets/comment_box.dart';
import 'package:clientf/pages/post_list/widgets/comment_list.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostListItem extends StatefulWidget {
  PostListItem(
    this.post, {
    Key key,
  }) : super(key: key);

  final EnginePost post;

  @override
  _PostListItemState createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  bool showContent = true;
  bool showCommentBox = false;
  
  @override
  void initState() {
    print('--> _PostListItemState::initState() called for: ${widget.post.id}');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // if ( widget.post == null ) return SizedBox.shrink();

    // print('--> _PostListItemState: build(): ${widget.post}');
    if (showContent) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'title: ${widget.post.title}',
                  style: TextStyle(fontSize: 32),
                ),
                Text('author: ${widget.post.uid}'),
                Text('created: ${widget.post.createdAt}'),
                Text('content: ${widget.post.content}'),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() {
                    forumModel(context).prepareCommentBox(widget.post);
                    showCommentBox = !showCommentBox;
                  });
                },
                child: Text('Reply'),
              ),
              RaisedButton(
                onPressed: () async {
                  // print('go to edit page:');
                  // print(widget.post);

                  /// TODO: 로직을 ForumModel 로 집어 넣을 것.
                  final EnginePost post = await open(AppRoutes.postUpdate,
                      arguments: {'post': widget.post});
                  Provider.of<EngineForumModel>(context, listen: false)
                      .updatePost(post);

                  /// TODO: update post list after updating a post.
                  // print(post);
                },
                child: Text('Edit'),
              ),
              RaisedButton(
                onPressed: () async {
                  print(widget.post);
                  //// 여기서 부터. 게시글 삭제. 게시글 삭제 후. 코멘트 CRUD.
                  AppService.confirm(
                    title: 'confirm',
                    content: 'do you want to delete?',
                    onYes: () async {
                      /// TODO: 로직을 ForumModel 로 집어 넣을 것.
                      try {
                        final re = await app.f.postDelete(widget.post.id);
                        setState(() {
                          widget.post.title = re.title;
                          widget.post.content = re.content;
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
              widget.post,
              onCancel: () => setState(() => showCommentBox = false),
              onSubmit: () => setState(() => showCommentBox = false),
              key: ValueKey('PostListItem::CommentBox::' + widget.post.id),
            ),

          CommentList(
            widget.post,
            key: ValueKey('ColumnList${widget.post.id}'),
          )
        ],
      );
    } else {
      return ListTile(
        title: Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),

          /// This padding is for testing.
          child: Text(widget.post.title ?? 'No title'),
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
