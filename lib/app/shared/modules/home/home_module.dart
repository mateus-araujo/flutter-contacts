import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

import 'package:contacts/app/shared/controllers/home/home_controller.dart';
import 'package:contacts/app/shared/modules/home/routes.android.dart';
import 'package:contacts/app/shared/modules/home/routes.ios.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/device/databases/sqflite_database.dart';
import 'package:contacts/device/repositories/sqflite_repository.dart';
import 'package:contacts/device/utils/contacts_database.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind<Database>(
      (_) => SQFLiteDatabase.create(
        ContactsDatabase.DATABASE_NAME,
        ContactsDatabase.CREATE_CONTACTS_TABLE_SCRIPT,
      ),
    ),
    Bind.lazySingleton<SQFLiteRepository>(
      (i) => SQFLiteRepository(ContactsDatabase.TABLE_NAME, i()),
    ),
    Bind.lazySingleton<ContactRepository>((i) => ContactRepository(i())),
    Bind.lazySingleton<HomeController>((i) => HomeController(i())),
  ];

  @override
  final List<ModularRoute> routes =
      Platform.isIOS ? HomeRoutesIOS.routes : HomeRoutesAndroid.routes;
}
