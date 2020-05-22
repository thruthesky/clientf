import 'package:flutter/material.dart';
import '../../services/app.defines.dart';
import '../../flutter_engine/engine.globals.dart';
import '../../flutter_engine/widgets/engine.login_form.dart';
import '../../flutter_engine/widgets/engine.text.dart';
import '../../globals.dart';
import '../../services/app.space.dart';
import '../../widgets/app.drawer.dart';

class LoginPage extends StatelessWidget {
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
          child: EngineLoginForm(
            hintEmail: t('input email'),
            hintPassword: t('input password'),
            onLogin: (user) => open(Routes.home),
            onError: (e) => alert(t(e)),
          ),
        ),
      ),
    );
  }
}
