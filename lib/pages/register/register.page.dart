import 'package:clientf/enginf_clientf_service/enginf.defines.dart';
import 'package:clientf/enginf_clientf_service/enginf.user.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/display_uploaded_images.dart';
import 'package:clientf/widgets/upload_icon.dart';
import 'package:clientf/widgets/upload_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  EngineUser user = EngineUser();
  int progress = 0;
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
      body: SingleChildScrollView(
        child: app.loggedIn
            ? T(ALREADY_LOGIN_ON_REGISTER_PAGE)
            : Padding(
                padding: EdgeInsets.all(AppSpace.space),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    UploadIcon(
                      user,
                      (p) {
                        setState(() {
                          progress = p;
                        });
                      },
                      (String url) {
                        setState(() {});
                      },
                      icon: UserPhoto(user),
                    ),
                    UploadProgressBar(progress),
                    // DisplayUploadedImages(
                    //   user,
                    //   editable: true,
                    // ),
                    AppSpace.spaceBox,
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
                        // print('Register button pressed');
                        final data = getFormData();
                        try {
                          await app.f.register(data);
                          AppRouter.open(context, AppRoutes.home);
                        } catch (e) {
                          AppService.alert(null, t(e));
                        }
                      },
                      child: T('register submit'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class UserPhoto extends StatelessWidget {
  UserPhoto(
    this.user, {
    Key key,
  }) : super(key: key);

  final EngineUser user;
  @override
  Widget build(BuildContext context) {
    String url;
    if (user.urls != null && user.urls.length > 0) {
      url = user.urls[0];
    }

    return Column(
      children: <Widget>[
        if (url == null)
          Material(
            elevation: 4.0,
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.blueAccent,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  size: 128,
                  color: AppColor.white,
                )),
          ),
        if (user != null)
          ClipOval(
            child: Image(
                image: NetworkImageWithRetry(url),
                width: 160,
                height: 160,
                fit: BoxFit.cover),
          ),
        AppSpace.halfBox,
        if (url == null) Text('Upload photo'),
        if (url != null) ...[
          Text('Change photo'),
          RaisedButton(
            onPressed: () {},
            child: T('Delete Photo'),
          ),
        ],
      ],
    );
  }
}
