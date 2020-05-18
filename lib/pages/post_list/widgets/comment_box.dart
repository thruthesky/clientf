import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/models/firestore.model.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/widgets/display_uploaded_images.dart';
import 'package:clientf/widgets/upload_icon.dart';
import 'package:clientf/widgets/upload_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class CommentBox extends StatefulWidget {
  CommentBox(
    this.post, {
    this.parentComment,
    this.currentComment,
    this.onSubmit,
    // this.onCancel,
    Key key,
  }) : super(key: key);
  final EnginePost post;

  /// When user creates a new comment, [parentComment] will be set.
  final EngineComment parentComment;

  /// When user updates a comment, [currentComemnt] will be set.
  final EngineComment currentComment;

  final Function onSubmit;
  // final Function onCancel;

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _contentController = TextEditingController();

  bool inLoading = false;
  int progress = 0;

  /// TODO: app model 로 이동할 것
  // File _imageFile;

  /// TODO: app model 로 이동 할 것.
  // Future<void> _pickImage(ImageSource source) async {
  //   _imageFile = await ImagePicker.pickImage(source: source);
  //   _startUpload();
  // }

  //// 여기서 부터. bottom sheet 이 열리지만 그 후 동작하지 않음.
  ///소스 참고: https://fireship.io/lessons/flutter-file-uploads-cloud-storage/
  /// 파일 업로드. 코멘트, 게시글, 사용자 사진을 업로드한다.
  ///업로드하는 사진은, quality 를 90% 로 하고, 너비를 024px 로 자동으로 줄인다.
  ///
  /// * 주의: storageBucket 는 파이어프로젝트마다 틀리다. 올바로 지정 해 주어야 한다.
  /// * 주의: 업로드된 이미지의 경로에서 슬래쉬가 %2F 로 되어져있는데, 웹브라우저로 접속할 때, 이걸 슬래쉬(/)로 하면 안되고, %2F 로 해야한다.
  ///   자등으로 바뀌는 경우가 있으므로, 가능하면 Postman 에서 확인을 한다.
  ///
  // final FirebaseStorage _storage =
  //     FirebaseStorage(storageBucket: 'gs://enginf-856e7.appspot.com');

  // StorageUploadTask _uploadTask;

  /// TODO - form validation
  getFormData() {
    final String content = _contentController.text;

    final Map<String, dynamic> data = {
      'content': content,
    };

    if (isCreate && widget.parentComment != null) {
      // comment under another comemnt
      data['postId'] = widget.post.id;
      data['parentId'] = widget.parentComment.id;
      data['depth'] = widget.parentComment.depth + 1;
    } else if (isUpdate) {
      // comment update
      data['id'] = widget.currentComment.id;
    } else {
      // comment under post
      data['postId'] = widget.post.id;
      data['depth'] = 0;
    }
    data['urls'] = widget.currentComment.urls;
    // print('data: ');
    // print(data);
    return data;
  }

  bool get isCreate {
    return widget.currentComment?.id == null;
  }

  bool get isUpdate {
    return !isCreate;
  }

  @override
  void initState() {
    Timer.run(() {
      // if (isCreate) {
      //   /// 임시 코멘트 생성. README 참고.
      //   widget.currentComment = EngineComment();
      // }
      if (isUpdate) {
        _contentController.text = widget.currentComment.content;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('edit comment'),
      ),
      body: SafeArea(
        child: Container(
          color: AppColor.light,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: T('원글 또는 부모 코멘트 글 목록까지만 보여주고 나머지 코멘트는 감춘다.'),
              ),
              Row(
                children: <Widget>[
                  UploadIcon(widget.currentComment, (p) {
                    setState(() {
                      progress = p;
                    });
                  }, (String url) {
                    setState(() {});
                  }),
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      onSubmitted: (text) {},
                      decoration: InputDecoration(
                        hintText: t('input comment'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: inLoading
                        ? PlatformCircularProgressIndicator()
                        : Icon(Icons.send),
                    onTap: () async {
                      if (inLoading) return;
                      setState(() {
                        inLoading = true;
                      });

                      var data = getFormData();
                      // print(getFormData());
                      try {
                        if (isCreate) {
                          /// create (reply)
                          var re = await app.f.commentCreate(data);
                          print('create: $data');
                          back(arguments: re);
                        } else {
                          /// update
                          var re = await app.f.commentUpdate(getFormData());
                          print('CommentBox:: Comment update. $re');
                          widget.currentComment.content = re.content;
                          back(arguments: re);
                        }
                      } catch (e) {
                        print(e);
                        AppService.alert(null, t(e));
                      }
                    },
                  ),
                ],
              ),
              UploadProgressBar(progress),
              DisplayUploadedImages(
                comment: widget.currentComment,
                editable: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
