import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.space.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget {
  const CommentItem(
    this.comment, {
    Key key,
  }) : super(key: key);
  final comment;

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  _CommentItemState() {}

  EngineComment comment;

  @override
  void initState() {
    comment = EngineComment.fromEnginData(widget.comment);

    print(comment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (comment == null) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpace.space),
      color: AppColor.scaffoldBackgroundColor,
      child: Text(comment.content),
    );
  }
}
