import 'package:flutter_modular/flutter_modular.dart';

class BindingService {
  static TBind get<TBind extends Object>() {
    return Modular.get<TBind>();
  }

  static Future<TBind> getAsync<TBind extends Object>() {
    return Modular.getAsync<TBind>();
  }

  static Future<void> isReady<TModule>() {
    return Modular.isModuleReady<TModule>();
  }
}
