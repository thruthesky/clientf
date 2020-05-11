import 'dart:async';

import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class PostCreatePage extends StatefulWidget {
  @override
  _PostCreatePageState createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  String id;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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
    };
    return data;
  }

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
            RaisedButton(
              onPressed: () async {
                try {
                  final re = await app.f.postCreate(getFormData());
                  back(arguments: re);
                } catch (e) {
                  AppService.alert(null, t(e));
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
