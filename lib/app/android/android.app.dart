import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/app/android/home/home.view.dart';
import 'package:contacts/app/android/loading/loading.view.dart';
import 'package:contacts/app/android/styles.dart';

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
            return HomeView();
          } else {
            return LoadingView();
          }
        },
      ),
      onGenerateRoute: _navigation.getRoute,
    );
  }
}
