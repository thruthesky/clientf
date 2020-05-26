import 'package:clientf/flutter_engine/widgets/engine.post_create_action_button.dart';

import '../../flutter_engine/widgets/latest_posts/engine.latest_posts.dart';
import '../../pages/home/widgets/home.top_menus.dart';
import '../../widgets/app.padding.dart';
import 'package:flutter/material.dart';

import '../../flutter_engine/engine.globals.dart';
import '../../flutter_engine/widgets/engine.app_bar.dart';

import '../../globals.dart';
import '../../services/app.defines.dart';

import '../../widgets/app.drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    //
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EngineAppBar(
        title: t('appName'),
        onTapUserPhoto: () =>
            open(ef.loggedIn ? Routes.register : Routes.login),
        actions: EnginePostCreateActionButton(),
      ),
      endDrawer: AppDrawer(),
      body: AppPadding(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeTopMenus(),
              EngineLatestPosts(
                'discussion',
                onTap: (post) =>
                    open(Routes.postView, arguments: {'post': post}),
                onError: alert,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
