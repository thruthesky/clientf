
import '../services/app.color.dart';
import '../services/app.space.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColor.primaryColor,
          primaryColorDark: AppColor.primaryColorDark,
          accentColor: AppColor.accentColor,
          scaffoldBackgroundColor: AppColor.white,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Color(0XFFf2f4f6),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpace.radius),
              borderSide: BorderSide(
                color: AppColor.primaryColorDark,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpace.radius),
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpace.radius),
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpace.radius),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
          ),
        );

