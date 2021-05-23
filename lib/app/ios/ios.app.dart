import 'package:flutter/cupertino.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/ios/styles.dart';

class IOSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      theme: iosTheme(),
    ).modular();
  }
}
