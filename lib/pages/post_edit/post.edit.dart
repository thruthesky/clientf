import 'dart:async';

import '../../flutter_engine/engine.globals.dart';
import '../../flutter_engine/widgets/engine.display_uploaded_images.dart';
import '../../flutter_engine/widgets/engine.text.dart';
import '../../flutter_engine/widgets/engine.upload_icon.dart';
import '../../flutter_engine/widgets/upload_progress_bar.dart';
import '../../globals.dart';
import '../../services/app.space.dart';
import '../../widgets/app.drawer.dart';

import '../../flutter_engine/engine.post.model.dart';

import 'package:flutter/material.dart';

class PostEditPage extends StatefulWidget {
  @override
  _PostEditPageState createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
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
            EngineDisplayUploadedImages(
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
                  onError: (e) => alert(t(e)),
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
                      alert(t(e));
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
