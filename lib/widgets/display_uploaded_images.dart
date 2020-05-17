import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:flutter/material.dart';

class DisplayUploadedImages extends StatelessWidget {
  DisplayUploadedImages({
    this.post,
    this.comment,
    this.editable = false,
  });

  final EnginePost post;
  final EngineComment comment;
  final bool editable;
  @override
  Widget build(BuildContext context) {
    List<dynamic> urls = this.post != null ? post.urls : comment.urls;
    if (urls == null || urls.length == 0) return SizedBox.shrink();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        maxCrossAxisExtent: 120,
        childAspectRatio: 5 / 3, // Grid 한 칸에 들어가는 Child Item 의 너비와 높이 비율
      ),
      itemCount: urls.length,
      itemBuilder: (context, i) {
        String url = urls.elementAt(i);
        return GridTile(
          child: Image.network(url),
        );
      },
    );
  }
}
