import 'package:clientf/enginf_clientf_service/enginf.category_list.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  EnginCategoryList list;

  @override
  void initState() {
    loadCategories();
    super.initState();
  }

  loadCategories() async {
    try {
      var data = await app.f.categoryList();

      // open(AppRoutes.categoryUpdate, arguments: {'id': 'banana'}); // TEST
      setState(() {
        list = data;
        print(list);
      });
    } catch (e) {
      AppService.alert(null, t(e));
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
                Expanded(
                  child: ListView.builder(
                    itemCount: list.ids.length,
                    itemBuilder: (context, i) {
                      var id = list.ids[i];
                      return ListTile(
                        title: Text(id),
                        subtitle: Text(list.data[id]['title'] + '\n' + list.data[id]['description']),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          open(
                            AppRoutes.categoryUpdate,
                            arguments: {'id': list.ids[i]},
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
