import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  /// Gets user registration data from the form
  /// TODO - form validation
  getFormData() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String nickname = _nicknameController.text;
    final String phoneNumber = _phoneNumberController.text;
    final String birthday = _birthdayController.text;

    /// 여기서 부터. 회원 정보에서 displayName, phoneNumber, photoURL 이... Auth 에 저장되고, Firestore 에 저장되지 않는지 확인.
    /// 회원 정보 수정. Auth 에 있는 값과 Firestore 에 있는 값을 모두 잘 수정하는지 확인.
    final data = {
      'email': email,
      'password': password,
      'displayName': nickname,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('Register'),
      ),
      endDrawer: AppDrawer(),
      body: Padding(
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
            TextField(
              controller: _nicknameController,
              onSubmitted: (text) {},
              decoration: InputDecoration(
                hintText: t('input nickname'),
              ),
            ),
            AppSpace.halfBox,
            TextField(
              controller: _phoneNumberController,
              onSubmitted: (text) {},
              decoration: InputDecoration(
                hintText: t('input phone number'),
              ),
            ),
            AppSpace.halfBox,
            TextField(
              controller: _birthdayController,
              onSubmitted: (text) {},
              decoration: InputDecoration(
                hintText: t('input birthday'),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                print('Register button pressed');
                final data = getFormData();
                final user = await app.register(data);
                if ( user != null ) {
                  AppRouter.open(context, AppRoutes.home);
                }
                // AppService.functions()
                //     .call({'route': 'user.register', 'data': data}).then((res) {
                //   app.login(data['email'], data['password']).then((user) {
                //     print(user.email);
                //   });
                // });
              },
              child: T('register submit'),
            ),
          ],
        ),
      ),
    );
  }
}
