import 'dart:async';

import 'package:flutter/material.dart';
import '../../services/app.defines.dart';
import '../../flutter_engine/engine.globals.dart';
import '../../flutter_engine/widgets/engine.app_bar.dart';
import '../../flutter_engine/widgets/engine.register_form.dart';
import '../../globals.dart';
import '../../services/app.space.dart';
import '../../widgets/app.drawer.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EngineAppBar(
        title: t('Register'),
        onTapUserPhoto: () =>
            open(ef.loggedIn ? Routes.register : Routes.login),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpace.page,
          child: EngineRegisterFrom(
            onError: alert,
            onRegisterSuccess: () => open(Routes.home),
            onUpdateSuccess: () => alert(t('profile updated')),
          ),
        ),
      ),
    );
  }
}
