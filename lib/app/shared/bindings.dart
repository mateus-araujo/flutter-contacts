import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/app/shared/controllers/home/home_controller.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/device/databases/sqflite_database.dart';
import 'package:contacts/device/repositories/sqflite_repository.dart';
import 'package:contacts/device/utils/contacts_database.dart';

void setup() {
  GetIt.instance.registerSingletonAsync<SQFLiteDatabase>(
    () async => await SQFLiteDatabase.create(
      ContactsDatabase.DATABASE_NAME,
      ContactsDatabase.CREATE_CONTACTS_TABLE_SCRIPT,
    ),
  );

  GetIt.instance.registerSingletonWithDependencies<ContactRepository>(() {
    final _sqfliteDatabase = GetIt.instance.get<SQFLiteDatabase>();
    final service = SQFLiteRepository(
        ContactsDatabase.TABLE_NAME, _sqfliteDatabase.database);
    final repository = ContactRepository(service);

    return repository;
  }, dependsOn: [SQFLiteDatabase]);

  GetIt.instance.registerSingletonWithDependencies<HomeController>(
    () => HomeController(),
    dependsOn: [ContactRepository],
  );

  GetIt.instance.registerSingletonAsync<CameraDescription>(() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    return firstCamera;
  });

  GetIt.instance.registerSingletonWithDependencies<CameraController>(() {
    final camera = GetIt.instance.get<CameraDescription>();

    final controller = CameraController(
      camera,
      ResolutionPreset.high,
    );

    return controller;
  }, dependsOn: [CameraDescription]);
}
