import 'package:clientf/globals.dart';
import 'package:clientf/models/app.localization.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:clientf/services/app.router.dart';
import 'package:clientf/services/app.service.dart';
import 'package:clientf/services/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {

  await Hive.initFlutter();
  await Hive.openBox(HiveBox.settings);
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
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => app),
      ],
      child: MaterialApp(
        theme: appTheme,
        // initialRoute: AppRoutes.home,
        initialRoute: AppRoutes.register,
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
