import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline1: base.headline1?.copyWith(
      fontFamily: 'Nunito',
      fontSize: 22.0,
      color: Colors.black,
    ));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Color(0xFF62369C),
  );
}