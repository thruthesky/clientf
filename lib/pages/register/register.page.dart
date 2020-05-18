import 'package:clientf/enginf_clientf_service/enginf.user.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.firestore.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
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
    ///
    final data = {
      'displayName': nickname,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
    };
    if (app.notLoggedIn) {
      data['email'] = email;
      data['password'] = password;
    }
    if (user.urls != null && user.urls.length > 0) {
      data['photoURL'] = user.urls[0];
    } else {
      data['photoURL'] = null;
    }
    print('data: ');
    print(data);
    return data;
  }

  @override
  void initState() {
    if (app.loggedIn) {
      loadProfile();
    }
    super.initState();
  }

  loadProfile() async {
    try {
      var _user = await app.f.profile();
      setState(() {
        user = _user;
        _nicknameController.text = user.displayName;
        _phoneNumberController.text = user.phoneNumber;
        _birthdayController.text = user.birthday;

        /// 사용자 사진을 `AppStore` 에서 수정 할 수 있도록 호환 작업.
        if (_user.photoURL != null) {
          user.urls = [_user.photoURL];
        }
        print('========> loadProfile()');
        print(user);
      });
    } catch (e) {
      AppService.alert(null, t(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T('Register'),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
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

              app.notLoggedIn
                  ? TextField(
                      controller: _emailController,
                      onSubmitted: (text) {},
                      decoration: InputDecoration(
                        hintText: t('input email'),
                      ),
                    )
                  : Text(user?.email ?? ''),
              AppSpace.halfBox,
              if (app.notLoggedIn)
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
                    if (app.notLoggedIn) {
                      await app.f.register(data);
                       AppRouter.open(context, AppRoutes.home);
                    } else {
                      await app.f.update(data);
                      AppService.alert(null, t('profile updated'));
                    }

                   
                  } catch (e) {
                    AppService.alert(null, t(e));
                  }
                },
                child:
                    app.notLoggedIn ? T('register submit') : T('update submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserPhoto extends StatefulWidget {
  UserPhoto(
    this.user, {
    Key key,
  }) : super(key: key);

  final EngineUser user;

  @override
  _UserPhotoState createState() => _UserPhotoState();
}

class _UserPhotoState extends State<UserPhoto> {
  @override
  Widget build(BuildContext context) {
    String url;
    print('UserPHoto::before: ');
    print(widget.user);
    print(widget.user.urls);
    if (widget.user.urls != null && widget.user.urls.length > 0) {
      url = widget.user.urls[0];
    }
    print('user url: $url');

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
        if (url != null)
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
            onPressed: () async {
              try {
                await AppStore(widget.user).delete(url);
                setState(() {});
              } catch (e) {
                t(e);
              }
            },
            child: T('Delete Photo'),
          ),
        ],
      ],
    );
  }
}
