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
    Key key,
  }) : super(key: key);

  final EnginePost post;
  final EngineComment parentComment;

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _contentController = TextEditingController();

  /// TODO - form validation
  getFormData() {
    final String content = _contentController.text;

    final data = {
      'postId': widget.post.id,
      'content': content,
    };
    if (widget.parentComment != null) {
      data['parentId'] = widget.parentComment.id;
    }
    return data;
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
            var re = await app.f.commentCreate(getFormData());
            print('CommentBox:: Comment created. $re');
            Provider.of<EngineForumModel>(context, listen: false)
                .addComment(re, widget.post.id, widget.parentComment?.id);
          },
        ),
      ],
    );
  }
}
