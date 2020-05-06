
import 'package:clientf/data/i18n.text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale) {
    // app.languageCode = locale.languageCode;
  }

  /// constructor 에서 locale 을 초기화
  final Locale locale;

  /// 보다 편하게 of 메소드를 사용 할 수 있도록 해 준다.
  ///
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// AppLocations.delegate 변수를 사용 할 수 있게 한다.
  /// 사실 꼭 이 함수는 필요 없으며 그냥 MateralApp( localizationDelegates: [ AppLocalizationsDelegate() ]) 를 해도 된다.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  /// Translates the text code into text
  /// @warning If you update the book and call this method immediately, then there might be no text available yet,
  ///   since it needs time to load all `default` texts into memory.
  /// 
  String t(String code, {Map<String, String>info}) {
    print('t:: $code, ${locale.languageCode}');
    if (code == null) return null;
    var texts = textTranslations;
    // print(texts);
    code = code.toLowerCase();
    if (texts == null || texts[code] == null || texts[code][locale.languageCode] == null ) {
      return code;
    }

    String text = texts[code][locale.languageCode];

    if ( info != null ) {
      for( String name in info.keys ) {
        text = text.replaceAll('#$name', info[name]);
      }
    }


    return text;
  }
}

/// App 에서 locale 을 사용 할 수 있도록 delegate 를 한다.
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  /// 지원 되는 언어를 지정한다.
  @override
  bool isSupported(Locale locale) => [
        'en',
        'ko',
        'ja',
        'vi',
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    /// JSON 파일은 async 를 통해서 로드해야하지만 dart 코드에 번역 문자열을 사용 할 때에는
    /// SynchronousFuture 를 사용하면 된다.
    /// 여기서 AppLocalizations(locale) 로 호출을 한다.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  /// Localizations Widget 이 rebuild 해야 할 때마다 호출되며,
  /// 만약 true 를 리턴하면 locale load 가 끝난 후, 자손 위젯들이 rebuild 해야 한다.
  /// 참고로 모든 예제와 심지어 모든 기본 Material Widgets 들이 false 를 리턴하고 있다.
  /// 그냥 계속, 의미 없이 false 를 리턴한다.
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
