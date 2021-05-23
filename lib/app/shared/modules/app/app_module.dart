import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/shared/modules/app/routes.android.dart';
import 'package:contacts/app/shared/modules/app/routes.ios.dart';
import 'package:contacts/app/shared/modules/auth/auth_module.dart';
import 'package:contacts/app/shared/modules/contact/contact_module.dart';
import 'package:contacts/app/shared/modules/home/home_module.dart';
import 'package:contacts/app/shared/modules/navigation/routes.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind<CameraDescription>((_) async {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      return firstCamera;
    }),
    Bind.lazySingleton<CameraController>((i) {
      final controller = CameraController(
        i(),
        ResolutionPreset.high,
      );

      return controller;
    }),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = Platform.isIOS
      ? [
          ModuleRoute(Routes.splash, module: AuthModule()),
          ModuleRoute(Routes.home, module: HomeModule()),
          ModuleRoute(Routes.contact, module: ContactModule()),
          ...AppRoutesIOS.routes.toList(),
        ]
      : [
          ModuleRoute(Routes.splash, module: AuthModule()),
          ModuleRoute(Routes.home, module: HomeModule()),
          ModuleRoute(Routes.contact, module: ContactModule()),
          ...AppRoutesAndroid.routes.toList(),
        ];
}
