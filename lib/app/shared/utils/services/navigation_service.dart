import 'package:flutter/widgets.dart';

import 'package:flutter_modular/flutter_modular.dart';

class NavigationService {
  static void pop<T extends Object?>([T? result, BuildContext? context]) {
    Modular.to.pop([result]);
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    BuildContext? context,
    Object? arguments,
  }) {
    return Modular.to.pushNamed(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    BuildContext? context,
    TO? result,
    Object? arguments,
  }) {
    return Modular.to.pushReplacementNamed(routeName, arguments: arguments);
  }
}
