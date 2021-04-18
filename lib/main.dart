import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:contacts/android/android.app.dart';
import 'package:contacts/core/settings/validation_locale.dart';
import 'package:contacts/ios/ios.app.dart';
import 'package:contacts/shared/bindings.dart';

void main() {
  setup();
  ValidationBuilder.globalLocale = ValidationLocale();

  if (Platform.isIOS) {
    runApp(IOSApp());
  } else {
    runApp(AndroidApp());
  }
}
