import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/pages/post_list/widgets/post_list.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  String id;
  List<EnginePost> posts = [];
  int limit = 10;

  bool loading = false;
  bool noMorePosts = false;

  final _scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 10), () {
      var _arg = routerArguments(context);
      setState(() {
        id = _arg['id'];
      });
      _fetchPosts();
    });

    _scrollController.addListener(_scrollListener);
    loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t(id ?? ''),
        actions: GestureDetector(
          child: Icon(Icons.add),
          onTap: () async {
            final EnginePost post =
                await open(AppRoutes.postCreate, arguments: {'id': id});

            if (post != null) {
              setState(() {
                posts.insert(0, post);
              });
            }
          },
        ),
      ),
      endDrawer: AppDrawer(),
      body: posts != null
          ? PostList(posts: posts, controller: _scrollController)
          : SizedBox.shrink(),
    );
  }

  _fetchPosts() async {
    if (noMorePosts) return;

    var req = {
      'categories': [id],
      'limit': limit,
      'includeComments': true,
    };
    if (posts.length > 0) {
      req['startAfter'] = posts[posts.length - 1].createdAt;
    }

    try {
      final _re = await app.f.postList(req);
      loading = false;
      if (_re.length < limit) {
        print('---------> No more posts!');
        noMorePosts = true;
      }
      // print(_re);
      setState(() {
        posts.addAll(_re);
      });
      // for (var _p in _re) {
      //   print(_p.title);
      // }
    } catch (e) {
      print(e);
      AppService.alert(null, t(e));
    }
  }

  void _scrollListener() {
    bool isBottom = _scrollController.offset >=
        _scrollController.position.maxScrollExtent - 200;

    if (isBottom && loading == false && !noMorePosts && mounted) {
      print('Load? $isBottom');
      setState(() {
        loading = true;
      });
      _fetchPosts();
      print('load again');
    }
  }
}
