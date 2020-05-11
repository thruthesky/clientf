import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class PostUpdatePage extends StatefulWidget {
  @override
  _PostUpdatePageState createState() => _PostUpdatePageState();
}

class _PostUpdatePageState extends State<PostUpdatePage> {
  EnginPost post;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () {
      var _arg = routerArguments(context);
      setState(() {
        post = _arg['post'];
        _titleController.text = post.title;
        _contentController.text = post.content;
      });
    });
  }

  /// TODO - form validation
  getFormData() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    final data = {
      'id': post.id,
      'title': title,
      'content': content,
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T(post?.title ?? ''),
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
            RaisedButton(
              onPressed: () async {
                try {
                  print(getFormData());
                  final re = await app.f.postUpdate(getFormData());
                  print(re);
                  back(arguments: re);
                } catch (e) {
                  print(e);
                  AppService.alert(null, t(e) + ': ' + e.message);
                }
              },
              child: T('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
