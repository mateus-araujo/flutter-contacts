import "package:flutter_modular/flutter_modular.dart";

import 'package:contacts/app/android/views/splash/splash.view.dart';
import 'package:contacts/app/shared/controllers/auth/auth_controller.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((_) => AuthController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SplashView()),
  ];
}
