import '../../../flutter_engine/engine.comment.model.dart';
import '../../../flutter_engine/engine.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/pages/post_list/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  CommentList(
    this.post, {
    Key key,
  }) : super(key: key);

  final EnginePost post;
  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    /// 글 하나에 달려있는 코멘트 목록을 표시한다.
    return Column(
      children: <Widget>[
        if (widget.post.comments != null)
          for (var c in widget.post.comments)
            CommentItem(
              widget.post,
              c,
              key: ValueKey(c.id ?? randomString()),
              onStateChanged: () => setState(() => {}),
            ),
      ],
    );
  }
}
