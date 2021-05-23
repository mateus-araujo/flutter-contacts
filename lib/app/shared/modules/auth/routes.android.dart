import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/android/views/splash/splash.view.dart';

class AuthRoutesAndroid {
  static List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SplashView()),
  ];
}
