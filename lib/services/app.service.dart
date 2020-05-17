import 'package:clientf/data/i18n.text.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/pages/post_list/widgets/comment_box.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.i18n.dart';
import 'package:clientf/services/app.keys.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';

class AppService {
  static var navigatorKey = GlobalKey<NavigatorState>();

  /// Returns the context of [navigatorKey]
  static BuildContext get context =>
      AppService.navigatorKey.currentState.overlay.context;

  static init() async {
    i18nTextKeyToLower();

    /// 앱이 실행 될 때마다 카운트를 한다.
    /// 첫 실행시 해야 할 것은 이 코드 이전에 해야 한다.
    increaseRun();
  }

  /// 앱이 처음 실해오디는 것이면 참를 리턴한다.
  static bool isFirstRun() {
    int runCount = getSetting(AppKey.runCount, defaultValue: 0);
    if (runCount == 0) {
      // print('========> This is FIRST RUN !');
      return true;
    } else {
      // print('Run count: $runCount');
      return false;
    }
  }

  /// TODO - Do we need to use Generic<Template> here?
  static dynamic getSetting(String key, {dynamic defaultValue}) {
    var settingBox = Hive.box(HiveBox.settings);
    return settingBox.get(key, defaultValue: defaultValue);
  }

  static dynamic setSetting(String key, value) {
    var settingBox = Hive.box(HiveBox.settings);
    return settingBox.put(key, value);
  }

  static increaseRun() {
    int run = getSetting(AppKey.runCount, defaultValue: 0);
    run++;
    setSetting(AppKey.runCount, run);
  }

  /// Show alert box
  /// @example AppService.alert(null, e.message);
  static alert(String title, String content) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(content),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText(t('Ok')),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// Can it be synchronous by using async/await? So, it does not need to use callback functions.
  static confirm(
      {String title, String content, Function onNo, Function onYes}) {
    return showPlatformDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: T('no'),
              onPressed: () {
                onNo();
                back();
              },
            ),
            FlatButton(
              child: T('yes'),
              onPressed: () {
                onYes();
                back();
              },
            )
          ],
        );
      },
    );
  }

  static bottomSheet(List<Map<String, dynamic>> items) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                for (var item in items)
                  new ListTile(
                    leading: new Icon(item['icon']),
                    title: new Text(item['text']),
                    onTap: item['onTap'],
                    // new ListTile(
                    //   leading: new Icon(Icons.videocam),
                    //   title: new Text('Video'),
                    //   onTap: () => {},
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  static openCommentBox(post, parentComment, currentComment) {
    return openDialog(CommentBox(
      post,
      parentComment: parentComment,
      currentComment: currentComment,
    ));
  }

  static openDialog(childWidget) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return childWidget;
      },
    );
  }
}
