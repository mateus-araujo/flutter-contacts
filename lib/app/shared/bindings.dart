import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/app/shared/controllers/home_controller.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/device/databases/sqflite_connection.dart';
import 'package:contacts/device/repositories/sqflite_repository.dart';
import 'package:contacts/device/utils/contacts_database.dart';

void setup() {
  GetIt.instance.registerSingletonAsync<SQFLiteConnection>(
    () async => await SQFLiteConnection.create(
      ContactsDatabase.DATABASE_NAME,
      ContactsDatabase.CREATE_CONTACTS_TABLE_SCRIPT,
    ),
  );

  GetIt.instance.registerSingletonWithDependencies<ContactRepository>(() {
    final database = GetIt.instance.get<SQFLiteConnection>();
    final service =
        SQFLiteRepository(ContactsDatabase.TABLE_NAME, database.connection);
    final repository = ContactRepository(service);

    return repository;
  }, dependsOn: [SQFLiteConnection]);

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
