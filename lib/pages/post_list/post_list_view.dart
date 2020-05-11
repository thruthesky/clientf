import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/pages/post_list/post_list_tile.dart';
import 'package:flutter/material.dart';

class PostListView extends StatelessWidget {
  const PostListView({
    Key key,
    @required this.posts,
  }) : super(key: key);

  final List<EnginPost> posts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, i) {
          return PostListTitle(posts[i]);
        },
      ),
    );
  }
}
