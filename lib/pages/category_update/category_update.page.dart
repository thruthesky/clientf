import 'dart:async';

import 'package:clientf/flutter_engine/engine.globals.dart';
import 'package:clientf/flutter_engine/widgets/engine.text.dart';

import '../../flutter_engine/engine.category.model.dart';
import 'package:clientf/globals.dart';

import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class CategoryUpdatePage extends StatefulWidget {
  @override
  _CategoryUpdatePageState createState() => _CategoryUpdatePageState();
}

class _CategoryUpdatePageState extends State<CategoryUpdatePage> {
  EngineCategory data;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  /// TODO - form validation
  getFormData() {
    final String title = _titleController.text;
    final String description = _descriptionController.text;

    final category = {
      'id': data.id,
      'title': title,
      'description': description,
    };
    return category;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 10), () async {
      var arguments = routerArguments(context);
      var _data = await ef.categoryData(arguments['id']);
      setState(() {
        data = _data;
        _titleController.text = data.title;
        _descriptionController.text = data.description;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data?.id ?? ''),
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
                hintText: t('input category title'),
              ),
            ),
            AppSpace.halfBox,
            TextField(
              controller: _descriptionController,
              onSubmitted: (text) {},
              decoration: InputDecoration(
                hintText: t('input category description'),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                ///
                print(getFormData());
                try {
                  final re = await ef.categoryUpdate(getFormData());
                  print(re);
                } catch (e) {
                  AppService.alert(null, t(e));
                  print(e);
                }
              },
              child: T('Category Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
