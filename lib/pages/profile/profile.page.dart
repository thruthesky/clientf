import 'dart:async';

import 'package:clientf/enginf_clientf_service/enginf.user.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  EnginfUser userData;

  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  /// Gets user registration data from the form
  /// TODO - form validation
  getFormData() {
    // final String email = _emailController.text;
    // final String password = _passwordController.text;
    final String nickname = _nicknameController.text;
    final String phoneNumber = _phoneNumberController.text;
    final String birthday = _birthdayController.text;

    /// 여기서 부터. 회원 정보에서 displayName, phoneNumber, photoURL 이... Auth 에 저장되고, Firestore 에 저장되지 않는지 확인.
    /// 회원 정보 수정. Auth 에 있는 값과 Firestore 에 있는 값을 모두 잘 수정하는지 확인.
    final data = {
      // 'email': email,
      // 'password': password,
      'displayName': nickname,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
    };
    return data;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    if (app.f.user == null) {
      Timer(Duration(milliseconds: 1500), loadProfile);
    } else {
      loadProfile();
    }
  }

  loadProfile() async {
    try {
      userData = await app.f.profile();
      setState(() {
        _nicknameController.text = userData.displayName;
        _phoneNumberController.text = userData.phoneNumber;
        _birthdayController.text = userData.birthday;
      });
    } catch (e) {
      AppService.alert(null, t(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('Profile'),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpace.space),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              userData == null
                  ? PlatformCircularProgressIndicator()
                  : Text(userData.email),
              AppSpace.halfBox,
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
                  print('Prifole update button pressed');
                  final data = getFormData();
                  try {
                    var updated = await app.f.update(data);
                    print(updated);
                    // AppRouter.open(context, AppRoutes.home);
                  } catch (e) {
                    AppService.alert(null, t(e));
                  }
                },
                child: T('profile submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
