import 'dart:async';

import 'package:clientf/flutter_engine/engine.globals.dart';
import 'package:clientf/flutter_engine/widgets/engine.text.dart';
import 'package:clientf/flutter_engine/widgets/engine.upload_icon.dart';
import 'package:clientf/flutter_engine/widgets/upload_progress_bar.dart';

import '../../flutter_engine/engine.post.model.dart';
import 'package:clientf/globals.dart';

import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/engine/display_uploaded_images.dart';
import 'package:flutter/material.dart';

class PostCreatePage extends StatefulWidget {
  @override
  _PostCreatePageState createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  EnginePost post = EnginePost();
  String postId;
  int progress = 0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () {
      var _arg = routerArguments(context);
      setState(() {
        /// 글 생성시, post.id (카테고리)
        postId = _arg['id'];

        /// 글 수정시, post document.
        var _post = _arg['post'];
        if (_post != null) {
          post = _post;
          _titleController.text = post.title;
          _contentController.text = post.content;
        }
      });
    });
  }

  /// TODO - form validation
  getFormData() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    /// TODO: 카테고리는 사용자가 선택 할 수 있도록 옵션 처리 할 것.
    final data = {
      'categories': isCreate ? [postId] : post.categories,
      'title': title,
      'content': content,
      'urls': post.urls,
    };

    if (isUpdate) {
      data['id'] = post.id;
    }
    return data;
  }

  bool get isCreate => postId != null;
  bool get isUpdate => !isCreate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T(postId ?? post.title ?? ''),
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
            EngineProgressBar(0),
            DisplayUploadedImages(
              post,
              editable: true,
            ),
            AppSpace.halfBox,
            EngineProgressBar(progress),
            AppSpace.halfBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                EngineUploadIcon(
                  post,
                  onProgress: (p) {
                    setState(() {
                      progress = p;
                    });
                  },
                  onUploadComplete: (String url) {
                    setState(() {});
                  },
                  onError: (e) => AppService.alert(null, t(e)),
                ),
                RaisedButton(
                  onPressed: () async {
                    try {
                      var re;
                      if (isCreate) {
                        re = await ef.postCreate(getFormData());
                      } else {
                        re = await ef.postUpdate(getFormData());
                      }

                      back(arguments: re);
                    } catch (e) {
                      print(e);
                      AppService.alert(null, t(e));
                    }
                  },
                  child: T(isCreate ? 'Create Post' : 'Update Post'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
