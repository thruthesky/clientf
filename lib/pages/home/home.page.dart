import 'package:clientf/enginf_clientf_service/enginf.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: T('appName'),
      ),
      endDrawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            T('app subtitle'),
            AppSpace.spaceBox,
            T('관리자 로그인 이메일: admin@engin.com'),
            AppSpace.halfBox,
            T('관리자 로그인 비밀번호: 12345a'),
            AppSpace.spaceBox,
            Divider(
              color: Colors.black,
            ),
            Selector<EnginfModel, FirebaseUser>(
                builder: (context, user, child) {
                  if (user == null) return SizedBox.shrink();
                  return Column(
                    children: <Widget>[
                      Text('로그인 한 사용자 정보 '),
                      Text('user login: ${user.email}'),
                      Text('phoneNumber: ${user.phoneNumber}'),
                      Text('displayName: ${user.displayName}'),
                    ],
                  );
                },
                selector: (_, model) => model.user),
            Divider(
              color: Colors.black,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    AppRouter.open(context, AppRoutes.register);
                  },
                  child: T('Register'),
                ),
                RaisedButton(
                  onPressed: () {
                    AppRouter.open(context, AppRoutes.login);
                  },
                  child: T('Login'),
                ),
                RaisedButton(
                  onPressed: () {
                    AppRouter.open(context, AppRoutes.profile);
                  },
                  child: T('Profile'),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    open(AppRoutes.categoryList);
                  },
                  child: T('Create List'),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    open(AppRoutes.postList, arguments: {'id': 'discussion'});
                  },
                  child: T('Discussion Forum'),
                ),
                RaisedButton(
                  onPressed: () {
                    open(AppRoutes.postList, arguments: {'id': 'qna'});
                  },
                  child: T(
                    'QnA Forum',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
