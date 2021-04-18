import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/android/styles.dart';
import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/android/views/loading.view.dart';

class AndroidApp extends StatelessWidget {
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
    );
  }
}
