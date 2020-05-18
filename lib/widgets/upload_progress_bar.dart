import 'package:flutter/material.dart';

class UploadProgressBar extends StatelessWidget {
  UploadProgressBar(this.progress);
  final int progress;
  @override
  Widget build(BuildContext context) {
    if (progress == null || progress == 0) return SizedBox.shrink();
    return Column(
      children: [
        LinearProgressIndicator(value: progress / 100),
        Text('$progress % '),
      ],
    );
  }
}
