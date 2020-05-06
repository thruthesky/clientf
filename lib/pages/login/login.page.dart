import 'package:clientf/globals.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('login page title'),
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
            RaisedButton(
              onPressed: () async {
                final data = getFormData();

                try {
                  final user = await app.login(data['email'], data['password']);
                  if (user == null) {
                    print('Error login');
                  } else {
                    print('success login');
                  }
                } on PlatformException catch (e) {
                  final code = e.code.toLowerCase();
                  if (code == ERROR_INVALID_EMAIL) {
                    AppService.alert(null, t(ERROR_INVALID_EMAIL));
                  } else if (code == ERROR_USER_NOT_FOUND) {
                    AppService.alert(null, t(ERROR_USER_NOT_FOUND));
                  } else if (code == ERROR_WRONG_PASSWORD) {
                    AppService.alert(null, t(ERROR_WRONG_PASSWORD));
                  }
                } catch (e) {
                  print(e);
                }

                // AppService.functions()
                //     .call({'route': 'user.register', 'data': data}).then((res) {
                //   app.login(data['email'], data['password']).then((user) {
                //     print(user.email);
                //   });
                // });
              },
              child: T('login submit'),
            ),
          ],
        ),
      ),
    );
  }
}
