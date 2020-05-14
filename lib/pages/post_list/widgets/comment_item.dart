import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/pages/post_list/widgets/comment_box.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.space.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget {
  const CommentItem(
    this.post,
    this.comment, {
    Key key,
  }) : super(key: key);
  final EnginePost post;
  final comment;

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  _CommentItemState();

  EngineComment comment;

  @override
  void initState() {
    comment = EngineComment.fromEnginData(widget.comment);

    print('CommentItem: $comment');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (comment == null) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpace.space),
      color: AppColor.scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Container(
              color: AppColor.light,
              margin: EdgeInsets.only(left: AppSpace.space * comment.depth),
              padding: EdgeInsets.all(AppSpace.space),
              child: Text('[${comment.depth}] ${comment.content}'),
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: T('reply'),
              ),
              RaisedButton(
                onPressed: () {},
                child: T('edit'),
              ),
            ],
          ),
          CommentBox(
            widget.post,
            parentComment: comment,
          ),
        ],
      ),
    );
  }
}
