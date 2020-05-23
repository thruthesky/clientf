import 'package:flutter/material.dart';

class AppPadding extends StatelessWidget {
  AppPadding({@required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: child,
    );
  }
}
