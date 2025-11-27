import 'package:flutter/material.dart';
import 'package:lab_mind_frontend/utils/styles/colors.dart';

ThemeData get appTheme {
  return ThemeData(
    buttonTheme: ButtonThemeData(),
    textTheme: const TextTheme(),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(),
    scaffoldBackgroundColor: MyColors.appBackgroundColor,
  );
}