import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:flutter/material.dart';

class PostListCommentBox extends StatefulWidget {
  PostListCommentBox(
    this.post, {
    Key key,
  }) : super(key: key);

  final EnginePost post;

  @override
  _PostListCommentBoxState createState() => _PostListCommentBoxState();
}

class _PostListCommentBoxState extends State<PostListCommentBox> {
  final TextEditingController _contentController = TextEditingController();

  /// TODO - form validation
  getFormData() {
    final String content = _contentController.text;

    final data = {
      'postId': widget.post.id,
      'content': content,
    };
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
              hintText: t('input content'),
            ),
          ),
        ),
        GestureDetector(
          child: Icon(Icons.send),
          onTap: () async {
            print(getFormData());
            var re = await app.f.commentCreate(getFormData());
            print(re);
          },
        ),
      ],
    );
  }
}
