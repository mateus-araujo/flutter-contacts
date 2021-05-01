import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:contacts/app/android/android.app.dart';
import 'package:contacts/app/ios/ios.app.dart';
import 'package:contacts/app/shared/bindings.dart';
import 'package:contacts/app/shared/utils/validation_locale.dart';

void main() {
  setup();
  ValidationBuilder.globalLocale = ValidationLocale();

  if (Platform.isIOS) {
    runApp(IOSApp());
  } else {
    runApp(AndroidApp());
  }
}
