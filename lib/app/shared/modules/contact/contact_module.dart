import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/shared/controllers/contact/contact_controller.dart';
import 'package:contacts/app/shared/modules/contact/routes.android.dart';
import 'package:contacts/app/shared/modules/contact/routes.ios.dart';
import 'package:contacts/data/repositories/address_repository.dart';
import 'package:contacts/data/services/http_service.dart';
import 'package:contacts/device/repositories/location_repository.dart';

class ContactModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<AddressRepository>((_) => AddressRepository()),
    Bind.lazySingleton<ContactController>((_) => ContactController()),
    Bind.lazySingleton<LocationRepository>((_) => LocationRepository()),
    Bind.lazySingleton<HttpService>((_) => HttpService()),
  ];

  @override
  final List<ModularRoute> routes =
      Platform.isIOS ? ContactRoutesIOS.routes : ContactRoutesAndroid.routes;
}
