import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/pages/post_list/post_list_tile.dart';
import 'package:flutter/material.dart';

class PostListView extends StatelessWidget {
  PostListView({Key key, @required this.posts, this.controller})
      : super(key: key);

  final List<EnginPost> posts;
  var controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // itemExtent: 120.0,
      itemCount: posts.length,
      controller: controller,
      itemBuilder: (context, i) {
        return PostListTitle(posts[i]);
      },
    );
  }
}
