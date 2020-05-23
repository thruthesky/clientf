import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../services/app.defines.dart';
import '../../../flutter_engine/engine.category.model.dart';
import '../../../flutter_engine/engine.category_list.model.dart';
import '../../../flutter_engine/engine.globals.dart';
import '../../../flutter_engine/widgets/engine.text.dart';
import '../../../globals.dart';
import '../../../widgets/app.drawer.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  EngineCategoryList list;

  @override
  void initState() {
    loadCategories();
    super.initState();
  }

  loadCategories() async {
    try {
      var data = await ef.categoryList();

      // open(AppRoutes.categoryUpdate, arguments: {'id': 'banana'}); // TEST

      if (!mounted) return;
      setState(() {
        list = data;
        print(list);
      });
    } catch (e) {
      /// mount check?
      alert(t(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('category list'),
      ),
      endDrawer: AppDrawer(),
      body: list == null
          ? PlatformCircularProgressIndicator()
          : Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    final re = await open(Routes.categoryEdit);
                    if (re != null) {
                      /// TODO: update the list when it gets newly created category data.
                      /// This is only for admin & There shouldn't be much categories.
                      /// So, just reloading the whole category list will be fine.
                      print('CategoryList::createCategory: $re');
                      loadCategories();
                    }
                  },
                  child: T('Create Category'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list.categories.length,
                    itemBuilder: (context, i) {
                      EngineCategory cat = list.categories[i];

                      // var id = list.ids[i];
                      return ListTile(
                        title: Text(cat.id),
                        subtitle: Text('${cat.title}\n${cat.description}'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          open(
                            Routes.categoryEdit,
                            arguments: {'category': cat},
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
