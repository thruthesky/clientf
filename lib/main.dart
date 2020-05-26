
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import './flutter_engine/engine.app.localization.dart';
import './flutter_engine/engine.globals.dart';
import './flutter_engine/engine.model.dart';
import './globals.dart';
import './services/app.defines.dart';
import './services/app.router.dart';
import './services/app.theme.dart';

void main() async {
  /// Hive 를 준비한다.
  /// 
  /// TODO: `Hive.initFlutter();` 코드는 반드시 여기에 위치해야 하는데, `Flutter Engine` 에서 assert 처리를 한다.
  await Hive.initFlutter();
  await Hive.openBox(HiveBox.settings);
  await Hive.openBox(HiveBox.cache);
  runApp(CommunityApp());
}

class CommunityApp extends StatefulWidget {
  @override
  _CommunityAppState createState() => _CommunityAppState();
}

class _CommunityAppState extends State<CommunityApp> {
  _CommunityAppState() {
    ef = EngineModel(navigatorKey: app.navigatorKey, onError: alert);


    /// 테스트 용도
    /// 
    /// 앱이 부팅하자 마자 게시판 카테고리로 이동하게 한다.
    /// 게시판 목록에서 작업을 할 때 편리.
    Timer(
      Duration(milliseconds: 100),
      () => open(
        Routes.postList,
        arguments: {'id': 'discussion'},
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      // testError();
      // testRouter();
      // testEngineUser();
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => app),
        ChangeNotifierProvider(create: (context) => ef),
      ],
      child: MaterialApp(
        theme: appTheme,
        initialRoute: Routes.home,
        // initialRoute: Routes.login,
        // initialRoute: Routes.categoryList,
        // initialRoute: Routes.register,
        // initialRoute: Routes.register,
        // initialRoute: Routes.admin,
        onGenerateRoute: AppRouter.generate,
        navigatorKey: app.navigatorKey,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ko', ''),
          const Locale('ja', ''),
          const Locale('zh', ''),
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
