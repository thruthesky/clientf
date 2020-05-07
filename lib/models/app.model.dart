import 'package:clientf/helpers/user_data.helper.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppModel extends ChangeNotifier {
  /// State of drawer
  /// true - open
  /// false - closed
  bool drawer = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// If user is null when no user is logged in.
  FirebaseUser user;

  AppModel() {
    print('AppModel() consturctor');
  }

  bool get loggedIn {
    return user != null;
  }

  bool get notLoggedIn {
    return loggedIn == false;
  }

  init() async {
    print('AppModel::init()');
    user = await _auth.currentUser();
    notifyListeners();
  }

  /// Let user log through the Firebase Auth
  /// It notifies & returns user object.
  /// When there is an Error, it will throw the error code. Only the code of the error.
  /// @example see README
  Future<FirebaseUser> login(String email, String password) async {
    if (email == null || email == '') {
      throw INPUT_EMAIL;
    }
    if (password == null || password == '') {
      throw INPUT_PASSWORD;
    }
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      if (result.user != null) {
        user = result.user;
      } else {
        throw ERROR_USER_IS_NULL;
      }
      notifyListeners();
      return user;
    } on PlatformException catch (e) {
      final code = e.code.toLowerCase();
      throw code;
      // if (code == ERROR_INVALID_EMAIL) {
      //   AppService.alert(null, t(ERROR_INVALID_EMAIL));
      // } else if (code == ERROR_USER_NOT_FOUND) {
      //   AppService.alert(null, t(ERROR_USER_NOT_FOUND));
      // } else if (code == ERROR_WRONG_PASSWORD) {
      //   AppService.alert(null, t(ERROR_WRONG_PASSWORD));
      // } else {
      //   AppService.alert(null, code);
      // }
      // return null;
    } catch (e) {
      throw e.message;
      // AppService.alert(null, t(e.message));
      // return null;
    }
  }

  /// If there is an Error, it will throw the error code.
  Future<FirebaseUser> register(data) async {
    var registeredUser = await AppService.callFunction(
      {'route': 'user.register', 'data': data},
    );
    final loggedUser = await login(registeredUser['email'], data['password']);
    return loggedUser;

    // var registeredUser;
    // try {
    //   registeredUser = await AppService.callFunction(
    //     {'route': 'user.register', 'data': data},
    //   );
    // } catch (e) {
    //   AppService.alert(null, t(e));
    //   return null;
    // }
    // try {
    //   final loggedUser = await login(registeredUser['email'], data['password']);
    //   return loggedUser;
    // } catch (e) {
    //   AppService.alert(null, t(e));
    //   return null;
    // }
  }

  /// Updates user data
  /// It can update not only `displayName` and `photoUrl` but also `phoneNumber` and all of other things.
  Future<UserData> update(data) async {
    data['uid'] = user.uid;
    var update = await AppService.callFunction(
      {'route': 'user.update', 'data': data},
    );
    await user.reload();
    user = await _auth.currentUser();
    return UserData.fromMap(update);
  }

  /// Gets user profile data from Firestore  & return user data as `UserData` helper class.
  /// @warning It does `NOT notifyListeners()` and does `NOT update user`.
  Future<UserData> profile() async {
    if (notLoggedIn || user?.uid == null) throw LOGIN_FIRST;
    // print(user.uid);
    return UserData.fromMap(await AppService.callFunction(
        {'route': 'user.data', 'data': user.uid}));
  }

  logout() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
