
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class CategoryCreatePage extends StatefulWidget {
  @override
  _CategoryCreatePageState createState() => _CategoryCreatePageState();
}

class _CategoryCreatePageState extends State<CategoryCreatePage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  /// TODO - form validation
  getFormData() {
    final String id = _idController.text;
    final String title = _titleController.text;
    final String description = _descriptionController.text;

    final data = {
      'id': id,
      'title': title,
      'description': description,
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('category create'),
      ),
      endDrawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppSpace.halfBox,
            TextField(
              controller: _idController,
              onSubmitted: (text) {},
              decoration: InputDecoration(
                hintText: t('input category id'),
              ),
            ),
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
                  final re = await app.f.categoryCreate(getFormData());
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
