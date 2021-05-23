import 'dart:io';

import "package:flutter_modular/flutter_modular.dart";

import 'package:contacts/app/shared/controllers/auth/auth_controller.dart';
import 'package:contacts/app/shared/modules/auth/routes.android.dart';
import 'package:contacts/app/shared/modules/auth/routes.ios.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((_) => AuthController()),
  ];

  @override
  final List<ModularRoute> routes =
      Platform.isIOS ? AuthRoutesIOS.routes : AuthRoutesAndroid.routes;
}
