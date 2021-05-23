import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/ios/views/splash/splash.view.dart';

class AuthRoutesIOS {
  static List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SplashView()),
  ];
}
