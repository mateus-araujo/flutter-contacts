import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/android/styles.dart';
import 'package:contacts/app/android/views/splash/splash.view.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      theme: androidTheme(),
      home: SplashView(),
    ).modular();
  }
}
