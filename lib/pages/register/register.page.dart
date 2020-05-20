import 'package:clientf/flutter_engine/engine.globals.dart';
import 'package:clientf/flutter_engine/widgets/engine.app_bar.dart';
import 'package:clientf/flutter_engine/widgets/engine.register_form.dart';


import 'package:clientf/services/app.defines.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EngineAppBar(
        title: t('Register'),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpace.space),
          child: EngineRegisterFrom(
            onError: (e) => AppService.alert(
              null,
              t(e),
            ),
            onRegisterSuccess: () => AppRouter.open(context, AppRoutes.home),
            onUpdateSuccess: () => AppService.alert(
              null,
              t('profile updated'),
            ),
          ),
        ),
      ),
    );
  }
}
