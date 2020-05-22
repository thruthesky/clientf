
import 'package:flutter/material.dart';

import '../../flutter_engine/engine.globals.dart';
import '../../flutter_engine/widgets/engine.app_bar.dart';
import '../../flutter_engine/widgets/engine.latest_posts.dart';
import '../../flutter_engine/widgets/engine.text.dart';

import '../../flutter_engine/engine.forum.dart';
import '../../globals.dart';
import '../../services/app.defines.dart';

import '../../widgets/app.drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EngineForum forum = EngineForum();
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
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HomeTopMenus(),
            EngineLatestPosts(
              'discussion',
              onTap: (post) => open(Routes.postView, arguments: {'post': post}),
              onError: alert,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTopMenus extends StatelessWidget {
  const HomeTopMenus({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            open(Routes.postList, arguments: {'id': 'discussion'});
          },
          child: T('Discussion'),
        ),
        RaisedButton(
          onPressed: () {
            open(Routes.postList, arguments: {'id': 'qna'});
          },
          child: T('QnA'),
        ),
        RaisedButton(
          onPressed: () {
            open(Routes.postList, arguments: {'id': 'qna'});
          },
          child: T('News'),
        ),
      ],
    );
  }
}
