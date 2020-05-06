import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  /// State of drawer
  /// true - open
  /// false - closed
  bool drawer = false;

  AppModel() {
    init();
  }
  init() async {}
}
