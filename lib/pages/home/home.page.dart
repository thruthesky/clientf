import 'package:clientf/enginf_clientf_service/enginf.forum.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/custom_app_bar.dart';
import 'package:clientf/widgets/post_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EngineForumList forum = EngineForumList();
  _HomePageState() {
    //
  }

  @override
  void initState() {
    loadPosts();

    super.initState();
  }

  loadPosts() {
    forum.id = 'discussion';
    forum.noOfPostsPerPage = 20;
    forum.loadPage(onLoad: () => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t('appName'),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HomeTopMenus(),
            LatestPosts(forum.posts),
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
            open(AppRoutes.postList, arguments: {'id': 'discussion'});
          },
          child: T('Discussion'),
        ),
        RaisedButton(
          onPressed: () {
            open(AppRoutes.postList, arguments: {'id': 'qna'});
          },
          child: T('QnA'),
        ),
        RaisedButton(
          onPressed: () {
            open(AppRoutes.postList, arguments: {'id': 'qna'});
          },
          child: T('News'),
        ),
      ],
    );
  }
}

class LatestPosts extends StatelessWidget {
  LatestPosts(
    this.posts, {
    Key key,
  }) : super(key: key);

  final List<EnginePost> posts;

  @override
  Widget build(BuildContext context) {
    // print('LatestPosts:: posts');
    for (EnginePost p in posts) print(p.title);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (EnginePost p in posts) ...[
          PostTitle(post: p),
          Divider(
            color: AppColor.divider,
          ),
        ]
      ],
    );
  }
}
