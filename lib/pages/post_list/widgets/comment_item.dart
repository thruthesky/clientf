import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.forum.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
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
  final EngineComment comment;

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  _CommentItemState();

  bool editMode = false;
  bool replyMode = false;

  @override
  void initState() {
    // print('CommentItem::initState() ${widget.comment}');
    if ( widget.comment.id == null ) {
      editMode = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.comment == null) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpace.space),
      color: AppColor.scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          if (editMode) // Edit comment
            Column(
              children: <Widget>[
                T('edit box'),
                CommentBox(
                  widget.post,
                  currentComment: widget.comment,
                  onCancel: () => setState(() => editMode = false),
                  onSubmit: () => setState(() {
                    print('got Submit event: ');
                    editMode = false;
                  }),
                  key: ValueKey('CommentBox${widget.comment.id}'),
                ),
              ],
            ),
          if (!editMode) // Show comment
            Column(
              children: <Widget>[
                CommentContent(comment: widget.comment),
                CommentButtons(
                  onReply: () => setState(() {
                    replyMode = !replyMode;
                  }),
                  onEdit: () => setState(() {
                    print('onEdit: (), got it:');
                    editMode = true;
                  }),
                  onDelete: () async {
                    /// Delte
                    var re = await app.f.commentDelete(widget.comment.id);
                    setState(() {
                      widget.comment.content = re['content'];
                    });
                  },
                ),
                if (replyMode)
                  CommentBox(
                    widget.post,
                    parentComment: widget.comment,
                    onCancel: () => setState(() => replyMode = false),
                    onSubmit: () => setState(() => replyMode = false),
                    // Will prevent 'element tree dup on test mode'.
                    key: ValueKey(
                        'CommentBoxReply::CommentBox::' + randomString()),
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
    // print('--> is EnginComment? ${comment.runtimeType}');
    return Container(
      width: double.infinity,
      child: Container(
        color: AppColor.light,
        margin: EdgeInsets.only(left: AppSpace.space * comment.depth),
        padding: EdgeInsets.all(AppSpace.space),
        child: Text('[${comment.depth}] ${comment.content}'),
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
