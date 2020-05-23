import 'package:flutter/material.dart';

class AppSpace {
  static double half = 8.0;
  static double space = 16.0;
  static double radius = 7.0;

  static final double lg = half;
  static final double xl = space;

  /// Page spacing
  /// @note there is no space on top.

  static EdgeInsets page =
      EdgeInsets.only(left: space, right: space, bottom: space);
  static Padding pagePadding = Padding(padding: page);

  static EdgeInsets top = EdgeInsets.only(top: space);

  static Padding topPadding = Padding(padding: top);

  static SizedBox spaceBox = SizedBox(
    width: space,
    height: space,
  );
  static SizedBox halfBox = SizedBox(
    width: half,
    height: half,
  );
}
