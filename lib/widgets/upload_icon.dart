import 'package:clientf/globals.dart';
import 'package:clientf/models/firestore.model.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadIcon extends StatelessWidget {
  UploadIcon(
    this.doc,
    this.onProgress,
    this.onUpload, {
    Key key,
  }) : super(key: key);

  /// 사용자 도큐먼트 또는 글/코멘트 도큐먼트 등
  final doc;

  /// 업로드 성공시 콜백
  final Function onUpload;

  /// 업로드 진행 콜백. Percentage 값을 알려 줌.
  final Function onProgress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.photo_camera),
      onTap: () {
        AppService.bottomSheet([
          {
            'icon': Icons.photo_camera,
            'text': t('Take photo from camera'),
            'onTap': () async {
              back();
              print('from camea');
              // String url =
              //     await Provider.of<FirestoreModel>(context, listen: false)
              //         .pickAndUploadImage(context, ImageSource.camera.index);

              String url = await FirestoreModel(doc).pickAndUploadImage(
                context,
                ImageSource.camera.index,
                onUploadComplete: onUpload,
                onUploadPercentage: onProgress,
              );
              print('UploadIcon:: camera: file uploaded: $url');
              // onUpload(url);
            }
          },
          {
            'icon': Icons.photo_album,
            'text': t('Take photo from Gallary'),
            'onTap': () async {
              back();
              // var model = Provider.of<FirestoreModel>(context, listen: false);

              // print('from gallery: doc: ${model.doc}');
              // String url = await model.pickAndUploadImage(
              //     context, ImageSource.gallery.index);

              // print('file uploaded: $url');
              // onUpload(url);

              String url = await FirestoreModel(doc).pickAndUploadImage(
                context,
                ImageSource.gallery.index,
                onUploadComplete: onUpload,
                onUploadPercentage: onProgress,
              );
              print('UploadIcon:: gallery: file uploaded: $url');
              // onUpload(url);
            }
          },
          {
            'icon': Icons.close,
            'text': t('cancel'),
            'onTap': () {
              back();
            }
          },
        ]);
      },
    );
  }
}
