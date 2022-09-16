import 'package:flutter/material.dart';

class AppFontStyle {
  static const String bahnschrift = 'Bahnschrift';
  static const String dancingScript = 'Dancing Script';

  static const boldDancingScriptTextFiled = TextStyle(
    fontFamily: dancingScript,
    fontSize: 70,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  static const normalDancingScriptTextFiled = TextStyle(
    fontFamily: dancingScript,
    fontSize: 22,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static const regularBahnschriftTextFiled = TextStyle(
    fontFamily: bahnschrift,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static const boldBahnschriftTextFiled = TextStyle(
    fontFamily: bahnschrift,
    fontSize: 25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );
}
