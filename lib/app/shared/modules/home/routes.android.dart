import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/android/views/home/home.view.dart';
import 'package:contacts/app/shared/modules/home/home_module.dart';
import 'package:contacts/app/shared/widgets/future_module_loading.dart';

class HomeRoutesAndroid {
  static List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => FutureModuleLoading<HomeModule>(child: HomeView()),
    ),
  ];
}
