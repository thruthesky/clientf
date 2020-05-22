import 'dart:async';

import 'package:flutter/material.dart';
import '../../../flutter_engine/engine.category.model.dart';
import '../../../flutter_engine/engine.globals.dart';
import '../../../flutter_engine/widgets/engine.text.dart';
import '../../../globals.dart';
import '../../../services/app.space.dart';
import '../../../widgets/app.drawer.dart';

class CategoryEditPage extends StatefulWidget {
  @override
  _CategoryEditPageState createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  EngineCategory category;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  /// TODO - form validation
  getFormData() {
    final String id = _idController.text;
    final String title = _titleController.text;
    final String description = _descriptionController.text;

    final data = {
      'title': title,
      'description': description,
    };
    if (isCreate)
      data['id'] = id;
    else
      data['id'] = category.id;
    return data;
  }

  bool get isCreate {
    return category == null;
  }

  bool get isUpdate {
    return !isCreate;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 10), () async {
      var _args = routerArguments(context);
      if (_args != null && _args['category'] != null) {
        category = _args['category'];
        setState(() {
          _titleController.text = category.title;
          _descriptionController.text = category.description;
        });
      }
      // print(category);
      // print(category.runtimeType);
      // // var _data = await ef.categoryData(arguments['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T(isCreate ? category?.id ?? '' : 'category create'),
      ),
      endDrawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isCreate) ...[
              AppSpace.halfBox,
              TextField(
                controller: _idController,
                onSubmitted: (text) {},
                decoration: InputDecoration(
                  hintText: t('input category id'),
                ),
              ),
            ],
            if (isUpdate) Text(category.id),
            AppSpace.halfBox,
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
                  var re;
                  if (isCreate)
                    re = await ef.categoryCreate(getFormData());
                  else
                    re = await ef.categoryUpdate(getFormData());
                  back(arguments: re);
                } catch (e) {
                  alert(t(e));
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
