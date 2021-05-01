import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/app/android/styles.dart';
import 'package:contacts/app/android/views/loading/loading.view.dart';
import 'package:contacts/app/android/views/splash/splash.view.dart';

import '../navigation/navigation.dart';

class AndroidApp extends StatelessWidget {
  final Navigation _navigation;

  AndroidApp() : _navigation = Navigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      theme: androidTheme(),
      home: FutureBuilder(
        future: GetIt.instance.allReady(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SplashView();
          } else {
            return LoadingView();
          }
        },
      ),
      onGenerateRoute: _navigation.getRoute,
    );
  }
}
