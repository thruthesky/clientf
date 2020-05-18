import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/display_uploaded_images.dart';
import 'package:clientf/widgets/upload_progress_bar.dart';
import 'package:flutter/material.dart';

class PostCreatePage extends StatefulWidget {
  @override
  _PostCreatePageState createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  String id;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  EnginePost post = EnginePost();
  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () {
      var _arg = routerArguments(context);
      setState(() {
        id = _arg['id'];
      });
    });
  }

  /// TODO - form validation
  getFormData() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    final data = {
      'categories': [id],
      'title': title,
      'content': content,
      'urls': post.urls,
    };

    return data;
  }

  /// 여기서 부터.
  /// FirestoreModel 을 처음 만들 때, 글 목록에서, 쓰기/수정을 다 한다는 계획이었는데,
  /// 지금은 페이지가 다 나뉘어져서 Model 을 없애고 가능한 callback 으로 한다.
  /// 그래야지. 다른 앱으로 작업을 할 때 쉬워진다. 다만 callback 을 매우 깨끗하게 작업을 해야 한다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T(id ?? ''),
      ),
      endDrawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              onSubmitted: (text) {},
              decoration: InputDecoration(
                hintText: t('input title'),
              ),
            ),
            AppSpace.halfBox,
            TextField(
              controller: _contentController,
              onSubmitted: (text) {},
              decoration: InputDecoration(
                hintText: t('input content'),
              ),
            ),
            AppSpace.halfBox,
            UploadProgressBar(0),
            DisplayUploadedImages(
              post: post,
              editable: true,
            ),
            AppSpace.halfBox,
            RaisedButton(
              onPressed: () async {
                try {
                  final re = await app.f.postCreate(getFormData());
                  back(arguments: re);
                } catch (e) {
                  AppService.alert(null, t(e));
                }
              },
              child: T('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
