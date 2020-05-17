import 'package:flutter/material.dart';

class DisplayUploadedImages extends StatelessWidget {
  DisplayUploadedImages(this.urls);

  final List<dynamic> urls;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (urls != null && urls is List) for (String url in urls) Image.network(url)
      ],
    );
  }
}
