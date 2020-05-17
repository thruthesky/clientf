import 'package:clientf/models/firestore.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 사진을 표시하고 삭제를 할 수 있다.
///
/// @see README 참고
/// DisplayUploadedImages 는 사진을 표시만 하고 삭제를 할 수 없다.
class UploadedImagesBox extends StatelessWidget {
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


