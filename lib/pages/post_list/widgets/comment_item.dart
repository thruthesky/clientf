import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.forum.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/display_uploaded_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItem extends StatefulWidget {
  const CommentItem(
    this.post,
    this.comment, {
    Key key,
  }) : super(key: key);
  final EnginePost post;
  final EngineComment comment;

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  _CommentItemState();

  @override
  Widget build(BuildContext context) {
    if (widget.comment == null) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpace.space),
      color: AppColor.scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              CommentContent(comment: widget.comment),
              CommentButtons(
                onReply: () async {
                  final re = await AppService.openCommentBox(
                      widget.post, widget.comment, null);
                  Provider.of<EngineForumModel>(context, listen: false)
                      .addComment(re, widget.post, widget.comment.id);
                },
                onEdit: () async {
                  final re = await AppService.openCommentBox(
                      widget.post, null, widget.comment);
                  Provider.of<EngineForumModel>(context, listen: false)
                      .addComment(re, widget.post, null);
                },
                onDelete: () async {
                  /// Delte
                  var re = await app.f.commentDelete(widget.comment.id);
                  setState(() {
                    widget.comment.content = re['content'];
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CommentContent extends StatelessWidget {
  const CommentContent({
    Key key,
    @required this.comment,
  }) : super(key: key);

  final EngineComment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Container(
        color: AppColor.light,
        margin: EdgeInsets.only(left: AppSpace.space * comment.depth),
        padding: EdgeInsets.all(AppSpace.space),
        child: Column(
          children: <Widget>[
            DisplayUploadedImages(comment: comment,),
            Text('[${comment.depth}] ${comment.content}'),
          ],
        ),
      ),
    );
  }
}

class CommentButtons extends StatelessWidget {
  CommentButtons({
    this.onReply,
    this.onEdit,
    this.onDelete,
  });
  final Function onReply;
  final Function onEdit;
  final Function onDelete;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RaisedButton(
          onPressed: onReply,
          child: T('reply'),
        ),
        RaisedButton(
          onPressed: onEdit,
          child: T('edit'),
        ),
        RaisedButton(
          onPressed: onDelete,
          child: T('delete'),
        ),
      ],
    );
  }
}
