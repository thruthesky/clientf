import '../flutter_engine/enginf.error.model.dart';
import 'package:clientf/models/app.localization.dart';
import 'package:clientf/services/app.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Returns translated string from the text code.
/// If [code] is [EngineError], then it takes [EngineError.code] as [code] and translate it.
String t(code, {info}) {
  // print(code);
  if (code is EngineError) {
    code = code.code;
    // if (info == null) info = code.message;
  }
  if ( code is FlutterError ) code = code.message;
  if ( code is PlatformException ) {
    code = code.details;
  }
  return AppLocalizations.of(AppService.context).t(code, info: info);
}

/// App language code
/// @return two letter string
///   'ko' - Korean
///   'en' - English
///   'zh' - Chinese
///   'ja' - Japanese.
String appLanguageCode() {
  return AppLocalizations.of(AppService.context).locale.languageCode;
}

/// Text widget that supports i18n tranlsation.
Text T(
  data, {
  Key key,
  style,
  strutStyle,
  textAlign,
  textDirection,
  locale,
  softWrap,
  overflow,
  textScaleFactor,
  maxLines,
  semanticsLabel,
  textWidthBasis,
}) {
  return Text(
    t(data),
    key: key,
    style: style,
    strutStyle: strutStyle,
    textAlign: textAlign,
    textDirection: textDirection,
    locale: locale,
    softWrap: softWrap,
    overflow: overflow,
    textScaleFactor: textScaleFactor,
    maxLines: maxLines,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
  );
}
