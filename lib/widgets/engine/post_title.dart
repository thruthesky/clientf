import 'package:clientf/flutter_engine/engine.defines.dart';
import 'package:clientf/flutter_engine/engine.globals.dart';

import '../../flutter_engine/engine.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';

import 'package:clientf/services/app.space.dart';
import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({
    Key key,
    @required this.post,
  }) : super(key: key);

  final EnginePost post;

  @override
  Widget build(BuildContext context) {
    String title;
    if (post.title == null || post.title == '')
      title = t(NO_TITLE);
    else if (post.title == POST_TITLE_DELETED)
      title = t(POST_TITLE_DELETED);
    else
      title = post.title;

    return GestureDetector(
      onTap: () => open(AppRoutes.postView, arguments: {'post': post}),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: AppSpace.half, bottom: AppSpace.half),
        child: Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
