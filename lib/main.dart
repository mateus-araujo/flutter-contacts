import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_validator/form_validator.dart';

import 'package:contacts/app/android/android.app.dart';
import 'package:contacts/app/app_module.dart';
import 'package:contacts/app/ios/ios.app.dart';
import 'package:contacts/app/shared/utils/validation_locale.dart';

Future<void> main() async {
  await DotEnv.load();

  ValidationBuilder.globalLocale = ValidationLocale();

  runApp(ModularApp(
    module: AppModule(),
    child: Platform.isIOS ? IOSApp() : AndroidApp(),
  ));
}
