import 'dart:async';

import 'package:clientf/flutter_engine/engine.defines.dart';
import 'package:clientf/flutter_engine/widgets/engine.button.dart';
import 'package:clientf/widgets/app.padding.dart';
import 'package:flutter/material.dart';
import '../../../flutter_engine/engine.category.helper.dart';
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
  bool inSubmit = false;
  bool inDelete = false;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T(isCreate ? category?.id ?? '' : 'category create'),
      ),
      endDrawer: AppDrawer(),
      body: AppPadding(
        child: Center(
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
              EngineButton(
                loader: inSubmit,
                text: isCreate ? CREATE_CATEGORY : UPDATE_CATEGORY,
                onPressed: () async {
                  if (inSubmit) return;
                  setState(() => inSubmit = true);
                  try {
                    var re;
                    if (isCreate)
                      re = await ef.categoryCreate(getFormData());
                    else
                      re = await ef.categoryUpdate(getFormData());
                    back(arguments: re);
                  } catch (e) {
                    alert(e);
                    setState(() => inSubmit = false);
                  }
                },
              ),
              if (isUpdate)
                EngineButton(
                  loader: inDelete,
                  text: DELETE_CATEGORY,
                  onPressed: () async {
                    if (inDelete) return;

                    /// 코멘트 삭제
                    confirm(
                      title: t(CONFIRM_COMMENT_DELETE_TITLE),
                      content: t(CONFIRM_COMMENT_DELETE_CONTENT),
                      onYes: () async {
                        setState(() => inDelete = true);
                        try {
                          var re =
                              await ef.categoryDelete({'id': this.category.id});
                          print('re: ');
                          print(re);
                          back(arguments: re);
                        } catch (e) {
                          alert(e);
                          setState(() => inDelete = false);
                        }
                      },
                      onNo: () {
                        // print('no');
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
