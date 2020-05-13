import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/pages/post_list/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  CommentList(this.post);

  final EnginePost post;
  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (widget.post.comments != null)
          for (var c in widget.post.comments) CommentItem(c),
      ],
    );
  }
}
