import 'package:clientf/models/firestore.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreModel>(
      builder: (context, model, child) {
        if (model.uploadTask == null || !model.uploadTask.isInProgress)
          return SizedBox.shrink();
        print('-> ${model.uploadPercentage}');
        return Column(
          children: [
            LinearProgressIndicator(value: model.uploadPercentage / 100),
            Text('${model.uploadPercentage.round()} % '),
          ],
        );
      },
    );
  }
}
