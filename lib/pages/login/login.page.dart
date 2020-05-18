import 'package:clientf/enginf_clientf_service/enginf.kakao.login.dart';
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
import 'package:kakao_flutter_sdk/all.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isKakaoTalkInstalled = true;

  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

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

  // 카카오 로그인 관련 코드
  // 처음 시작할 때 기기에 카카오톡이 설치되어 있는지 검사
  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  // 카카오톡 설치되어 있을 때 : 앱으로 로그인
  // 카카오톡 설치가 안되어 있을 때 : 웹으로 로그인
  Future<FirebaseUser> _handleSignInWithKakao() async {
    try {
      var authCode;
      if (_isKakaoTalkInstalled) {
        authCode = await AuthCodeClient.instance.requestWithTalk();
      } else {
        authCode = await AuthCodeClient.instance.request();
      }
      AccessTokenResponse tokenResponse =
      await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(tokenResponse);
      var customToken = await createKakaoCustomToken();

      final FirebaseUser user =
          (await _auth.signInWithCustomToken(token: customToken)).user;

      logOutTalk();
      return user;
    } catch (e) {
      print(e);
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
              RaisedButton(
                onPressed: () {
                  _handleSignInWithKakao()
                      .then((FirebaseUser user) => print(user))
                      .catchError((e) => print(e));
                },
                child: T('Kakao Sign-in'),
              ),
              RaisedButton(
                onPressed: () {
                  unlinkTalk();
                },
                child: T('Unlink kakao account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
