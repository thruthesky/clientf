import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.forum.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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

  bool inLoading = false;

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
    // print('data: ');
    // print(data);
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
          child: inLoading
              ? PlatformCircularProgressIndicator()
              : Icon(Icons.send),
          onTap: () async {
            if (inLoading) return;
            setState(() {
              inLoading = true;
            });
            // print(getFormData());
            try {
              if (widget.currentComment != null) {
                /// update
                var re = await app.f.commentUpdate(getFormData());
                print('CommentBox:: Comment update. $re');
                widget.currentComment.content = re['content'];
                // Provider.of<EngineForumModel>(context, listen: false)
                //     .addComment(re, widget.post.id, widget.parentComment?.id);
              } else {
                /// create (reply)
                /// TODO: 로더 표시. 연속 클릭으로 state 에러가 발생하고 있음.
                print('----------> reply');
                print(getFormData());
                var re = await app.f.commentCreate(getFormData());
                Provider.of<EngineForumModel>(context, listen: false)
                    .addComment(re, widget.post.id, widget.parentComment?.id);
              }
            } catch (e) {
              print(e);
              AppService.alert(null, t(e));
            }
            widget.onSubmit();
          },
        ),
        if (!inLoading)
          GestureDetector(
            child: Icon(Icons.cancel),
            onTap: widget.onCancel,
          ),
      ],
    );
  }
}
