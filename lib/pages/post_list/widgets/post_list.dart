import '../../../flutter_engine/enginf.forum.dart';
import 'package:clientf/widgets/engine/post_item.dart';
import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  PostList(this.forum, {Key key}) : super(key: key);

  final EngineForum forum;

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    /// 글을 목록한다.
    return ListView.builder(
      itemCount: widget.forum.posts.length,
      controller: widget.forum.scrollController,
      itemBuilder: (context, i) {
        return PostItem(widget.forum.posts[i]);
      },
    );
  }
}
