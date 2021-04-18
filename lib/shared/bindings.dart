import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/core/controllers/home_controller.dart';
import 'package:contacts/core/databases/sqflite_connection.dart';
import 'package:contacts/core/repositories/contact_repository.dart';
import 'package:contacts/core/services/sqflite_service.dart';
import 'package:contacts/core/settings/database.dart';

void setup() {
  GetIt.instance.registerSingletonAsync<SQFLiteConnection>(
    () async => await SQFLiteConnection.create(),
  );

  GetIt.instance.registerSingletonWithDependencies<ContactRepository>(() {
    final database = GetIt.instance.get<SQFLiteConnection>();
    final service = SQFLiteService(TABLE_NAME, database.connection);
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
