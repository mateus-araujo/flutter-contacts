import 'package:flutter/cupertino.dart';

import 'package:contacts/app/shared/styles.dart';

const brightness = Brightness.light;
const primaryColor = basePrimaryColor;
const accentColor = baseAccentColor;

CupertinoThemeData iosTheme() {
  return CupertinoThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
  );
}
