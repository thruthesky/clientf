import '../../../flutter_engine/engine.category_list.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../../services/app.defines.dart';
import '../../../flutter_engine/engine.category.helper.dart';
import '../../../flutter_engine/engine.globals.dart';
import '../../../flutter_engine/widgets/engine.text.dart';
import '../../../globals.dart';
import '../../../widgets/app.drawer.dart';

class CategoryListPage extends StatelessWidget {
  final EngineCategoryListModel categoryListModel = EngineCategoryListModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => categoryListModel),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: T('category list'),
        ),
        endDrawer: AppDrawer(),
        body: Consumer<EngineCategoryListModel>(
          builder: (context, model, child) {
            if (model.inLoading)
              return Center(
                child: PlatformCircularProgressIndicator(),
              );

            return Column(
              children: <Widget>[
                CreateCategoryButton(),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.list.categories.length,
                    itemBuilder: (context, i) {
                      EngineCategory cat = model.list.categories[i];
                      return ListTile(
                        title: Text(cat.id),
                        subtitle: Text('${cat.title}\n${cat.description}'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () async {
                          try {
                            await open(
                              Routes.categoryEdit,
                              arguments: {'category': cat},
                            );
                            model.loadCategories();
                          } catch (e) {
                            alert(e);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CreateCategoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        final re = await open(Routes.categoryEdit);
        if (re != null) {
          Provider.of<EngineCategoryListModel>(context, listen: false)
              .loadCategories();
        }
      },
      child: T('Create Category'),
    );
  }
}
