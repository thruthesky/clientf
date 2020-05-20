import 'package:clientf/globals.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.firestore.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// 업로드된 사진을 표시
///
class DisplayUploadedImages extends StatefulWidget {
  /// [doc] 사용자 도큐먼트
  DisplayUploadedImages(
    this.doc, {
    this.editable = false,
  });

  final doc;
  final bool editable;

  @override
  _DisplayUploadedImagesState createState() => _DisplayUploadedImagesState();
}

class _DisplayUploadedImagesState extends State<DisplayUploadedImages> {
  @override
  Widget build(BuildContext context) {
    if (widget.doc.urls == null || widget.doc.urls.length == 0)
      return SizedBox.shrink();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        maxCrossAxisExtent: 140,
        childAspectRatio: 5 / 3, // Grid 한 칸에 들어가는 Child Item 의 너비와 높이 비율
      ),
      itemCount: widget.doc.urls.length,
      itemBuilder: (context, i) {
        String url = widget.doc.urls.elementAt(i);
        return GridTile(
          child: Image(
            image: NetworkImageWithRetry(url),
          ),
          footer: DeleteIcon(
            widget.doc,
            url,
            widget.editable,
            () => setState(() {}),
            key: ValueKey(randomString()),
          ),
        );
      },
    );
  }
}

class DeleteIcon extends StatefulWidget {
  DeleteIcon(
    this.doc,
    this.url,
    this.editable,
    this.onDelete, {
    Key key,
  }) : super(key: key);

  final doc;
  final String url;
  final bool editable;
  final Function onDelete;

  @override
  _DeleteIconState createState() => _DeleteIconState();
}

class _DeleteIconState extends State<DeleteIcon> {
  bool inLoading = false;

  @override
  Widget build(BuildContext context) {
    if (widget.editable == false) return SizedBox.shrink();
    return MaterialButton(
      onPressed: () async {
        setState(() {
          inLoading = true;
        });
        try {
          await AppStore(widget.doc).delete(widget.url);
        } catch (e) {
          print(e);
          AppService.alert(null, t(e));
        }

        /// TODO: 파일을 삭제를 하면, 실패를 해도 [urls] 에서 없앤다. 즉, 실패를 하면, 파일이 없는 것으로 간주하는 것이다. 다른 에러가 있을 수 있으니 확인한다.
        widget.onDelete();
      },
      color: AppColor.light,
      child: inLoading
          ? PlatformCircularProgressIndicator()
          : Icon(
              Icons.delete,
              size: 24,
              color: AppColor.primaryColorDark,
            ),
      padding: EdgeInsets.all(4.0),
      shape: CircleBorder(),
    );
  }
}
