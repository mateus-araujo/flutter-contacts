import 'package:flutter/cupertino.dart';

import 'package:contacts/app/ios/styles.dart';
import 'package:contacts/app/ios/views/home.view.dart';

class IOSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      theme: iosTheme(),
      home: HomeView(),
    );
  }
}
