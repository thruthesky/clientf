
import 'package:clientf/globals.dart';
import 'package:clientf/models/app.localization.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveBox.settings);
  KakaoContext.clientId = "48a0fa6a6e0c650c919f5a00adba5d3f";
  runApp(CommunityApp());
}

class CommunityApp extends StatefulWidget {
  @override
  _CommunityAppState createState() => _CommunityAppState();
}

class _CommunityAppState extends State<CommunityApp> {
  _CommunityAppState() {
    AppService.init();
    app.init();

    // Timer(Duration(milliseconds: 100),
    //     () => open(AppRoutes.postList, arguments: {'id': 'discussion'}));
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
        ChangeNotifierProvider(create: (context) => app.f),
      ],
      child: MaterialApp(
        theme: appTheme,
        initialRoute: AppRoutes.home,
        // initialRoute: AppRoutes.login,
        // initialRoute: AppRoutes.categoryList,
        // initialRoute: AppRoutes.profile,
        // initialRoute: AppRoutes.register,
        onGenerateRoute: AppRouter.generate,
        navigatorKey: AppService.navigatorKey,
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
