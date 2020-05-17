import 'package:clientf/models/firestore.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 사진을 표시한다.
///
/// @see README 참고
class DisplayuploadedImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreModel>(builder: (context, model, child) {
      return Column(
        children: <Widget>[
          if (model?.doc?.urls != null)
            for (String url in model.doc.urls) Image.network(url)
        ],
      );
    });
  }
}
