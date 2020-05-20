import '../../flutter_engine/engine.user.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/services/app.color.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.firestore.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.space.dart';
import 'package:clientf/widgets/app.drawer.dart';
import 'package:clientf/widgets/custom_app_bar.dart';
import 'package:clientf/widgets/engine/upload_icon.dart';
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

    /// 회원 가입
    if (app.notLoggedIn) {
      /// 회원 가입시에만 이메일과 비빌번호를 지정
      data['email'] = email;
      data['password'] = password;

      /// 회원 가입을 할 때에는 사진이 `Anonymous` 로 업로드 되어져있는데,
      ///   - 그 사진의 URL 을 `Enginef`로 전달하고
      ///   - `Enginef`에서 해당 사용자의 `Firebase Auth` 에 기록을 한다.
      if (user.urls != null && user.urls.length > 0) {
        data['photoURL'] = user.urls[0];
      }
    }
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
      });
    } catch (e) {
      AppService.alert(null, t(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t('Register'),
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
                  /// 업로드 Percentage 표시
                  setState(() {
                    progress = p;
                  });
                },
                (String url) async {
                  /// 사진 업로드
                  try {
                    /// 사진을 업로드하면, `Enginef` 에 바로 저장을 해 버린다. 즉, 전송 버튼을 누르지 않아도 이미 업데이트가 되어져 버린다.
                    await ef.userUpdate({'photoURL': url});
                    setState(() {});
                  } catch (e) {
                    AppService.alert(null, t(e));
                  }
                },
                icon: UserPhoto(user),
              ),
              UploadProgressBar(progress),
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
                  /// 전송 버튼
                  final data = getFormData();
                  try {
                    if (app.notLoggedIn) {
                      await app.f.register(data);
                      AppRouter.open(context, AppRoutes.home);
                    } else {
                      await ef.userUpdate(data);
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
    /// `Firebase Auth` 의 `photoUrl` 을 바로 보여준다.
    String url = app.f.user?.photoUrl;
    bool hasPhoto = url != null && url != DELETED_PHOTO;
    return Column(
      children: <Widget>[
        hasPhoto
            ? ClipOval(
                child: Image(
                    image: NetworkImageWithRetry(url),
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover),
              )
            : Material(
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
        AppSpace.halfBox,
        if (!hasPhoto) Text('Upload photo'),
        if (hasPhoto) ...[
          Text('Change photo'),
          RaisedButton(
            onPressed: () async {
              /// 사진 삭제
              try {
                await AppStore(widget.user).delete(url);
                await ef.userUpdate({'photoURL': DELETED_PHOTO}); // @see README
                setState(() {});
              } catch (e) {
                AppService.alert(null, t(e));
              }
            },
            child: T('Delete Photo'),
          ),
        ],
      ],
    );
  }
}
