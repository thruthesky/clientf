import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Gets user registration data from the form
  /// TODO - form validation
  getFormData() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final data = {
      'email': email,
      'password': password,
    };
    return data;
  }

  Future<FirebaseUser> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);

      /// 파이어베이스에서 이미 로그인을 했으므로, GoogleSignIn 에서는 바로 로그아웃을 한다.
      /// GoogleSignIn 에서 로그아웃을 안하면, 다음에 로그인을 할 때, 다른 계정으로 로그인을 못한다.
      await _googleSignIn.signOut();
      return user;
    } catch (e) {
      print('Got error: ');
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('login page title'),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpace.space),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _emailController,
                onSubmitted: (text) {},
                decoration: InputDecoration(
                  hintText: t('input email'),
                ),
              ),
              AppSpace.halfBox,
              TextField(
                controller: _passwordController,
                onSubmitted: (text) {},
                decoration: InputDecoration(
                  hintText: t('input password'),
                ),
              ),
              AppSpace.halfBox,
              RaisedButton(
                onPressed: () async {
                  final data = getFormData();
                  try {
                    await app.login(data['email'], data['password']);
                    AppRouter.open(context, AppRoutes.home);
                  } catch (e) {
                    AppService.alert(null, t(e));
                  }
                },
                child: T('login submit'),
              ),
              RaisedButton(
                onPressed: () {
                  _handleSignIn()
                      .then((FirebaseUser user) => print(user))
                      .catchError((e) => print(e));
                },
                child: T('Google Sign-in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
