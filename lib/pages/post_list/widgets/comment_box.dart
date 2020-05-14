import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.forum.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentBox extends StatefulWidget {
  CommentBox(
    this.post, {
    this.parentComment,
    this.currentComment,
    this.onSubmit,
    this.onCancel,
    Key key,
  }) : super(key: key);

  final EnginePost post;

  /// When user creates a new comment, [parentComment] will be set.
  final EngineComment parentComment;

  /// When user updates a comment, [currentComemnt] will be set.
  final EngineComment currentComment;

  final Function onSubmit;
  final Function onCancel;

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _contentController = TextEditingController();

  /// TODO - form validation
  getFormData() {
    final String content = _contentController.text;

    final data = {
      'content': content,
    };

    if (widget.parentComment != null) {
      // comment under comemnt
      data['postId'] = widget.post.id;
      data['parentId'] = widget.parentComment.id;
    } else if (widget.currentComment != null) {
      // comment update
      data['id'] = widget.currentComment.id;
    } else {
      // comment under post 2
      data['postId'] = widget.post.id;
    }
    print('data: ');
    print(data);
    return data;
  }

  @override
  void initState() {
    if (widget.currentComment != null) {
      _contentController.text = widget.currentComment.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _contentController,
            onSubmitted: (text) {},
            decoration: InputDecoration(
              hintText: t('input comment'),
            ),
          ),
        ),
        GestureDetector(
          child: Icon(Icons.send),
          onTap: () async {
            print(getFormData());
            if (widget.currentComment != null) {
              /// update
              var re = await app.f.commentUpdate(getFormData());
              print('CommentBox:: Comment update. $re');
              widget.currentComment.content = re['content'];
              // Provider.of<EngineForumModel>(context, listen: false)
              //     .addComment(re, widget.post.id, widget.parentComment?.id);
            } else {
              /// create (reply)
              var re = await app.f.commentCreate(getFormData());
              print('CommentBox:: Comment created. $re');
              Provider.of<EngineForumModel>(context, listen: false)
                  .addComment(re, widget.post.id, widget.parentComment?.id);
            }

            widget.onSubmit();
          },
        ),
        GestureDetector(
          child: Icon(Icons.cancel),
          onTap: widget.onCancel,
        ),
      ],
    );
  }
}
