import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';

class PostListTitle extends StatefulWidget {
  PostListTitle(
    this.post, {
    Key key,
  }) : super(key: key);

  final EnginPost post;

  @override
  _PostListTitleState createState() => _PostListTitleState();
}

class _PostListTitleState extends State<PostListTitle> {
  bool showContent = false;
@override

  @override
  Widget build(BuildContext context) {
    if (showContent) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'title: ${widget.post.title}',
                  style: TextStyle(fontSize: 48),
                ),
                Text('author: ${widget.post.uid}'),
                Text('created: ${widget.post.created}'),
                Text('content: ${widget.post.content}'),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  AppService.alert(null, t('Not supported'));
                },
                child: Text('Reply'),
              ),
              RaisedButton(
                onPressed: () async {
                  print('go to edit page:');
                  print(widget.post);
                  final EnginPost post = await open(AppRoutes.postUpdate,
                      arguments: {'post': widget.post});

                  /// TODO: update post list after updating a post.
                  print(post);
                },
                child: Text('Edit'),
              ),
              RaisedButton(
                onPressed: () async {
                  print(widget.post);
                  //// 여기서 부터. 게시글 삭제. 게시글 삭제 후. 코멘트 CRUD.
                  AppService.confirm(
                    title: 'confirm',
                    content: 'do you want to delete?',
                    onYes: () async {
                      // print('yes');
                      try {
                        final re = await app.f.postDelete(widget.post.id);
                        print(re);
                        if (re.deleted is int) {
                          AppService.alert(null, t('post deleted'));
                        }
                      } catch (e) {}
                    },
                    onNo: () {
                      // print('no');
                    },
                  );
                },
                child: Text('Delete'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    showContent = false;
                  });
                },
                child: Text('Close'),
              ),
            ],
          ),
        ],
      );
    } else {
      return ListTile(
        title: Padding(
          padding: EdgeInsets.only(top: 60.0, bottom: 60.0),

          /// This padding is for testing.
          child: Text(widget.post.title ?? 'No title'),
        ),
        trailing: Icon(Icons.keyboard_arrow_down),
        onTap: () {
          setState(() {
            showContent = true;
          });
        },
      );
    }
  }

}
