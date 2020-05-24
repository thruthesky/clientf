import 'package:clientf/flutter_engine/engine.forum_list.model.dart';
import 'package:clientf/flutter_engine/widgets/forum/engine.post_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../flutter_engine/widgets/engine.text.dart';
import '../../globals.dart';
import '../../widgets/app.drawer.dart';

class PostViewPage extends StatefulWidget {
  @override
  _PostViewPageState createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  EngineForumListModel forum = EngineForumListModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _args = routerArguments(context);
    forum.posts = [_args['post']];
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => forum),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: T('글 읽기'),
        ),
        endDrawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Consumer<EngineForumListModel>(
            builder: (context, model, child) {
              return EnginePostView(_args['post']);
            },
          ),
        ),
      ),
    );
  }
}
