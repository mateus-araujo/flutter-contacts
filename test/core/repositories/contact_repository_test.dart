import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:contacts/core/models/contact.model.dart';
import 'package:contacts/core/repositories/contact_repository.dart';
import 'package:contacts/core/services/sqflite_service.dart';
import 'package:contacts/core/settings/database.dart';

main() {
  sqfliteFfiInit();
  WidgetsFlutterBinding.ensureInitialized();

  group('ContactRepository', () {
    late ContactRepository repository;
    late Database db;

    setUp(() async {
      db = await databaseFactoryFfi.openDatabase(
        inMemoryDatabasePath,
        options: OpenDatabaseOptions(
          onCreate: (db, version) {
            return db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
          },
          version: 1,
        ),
      );

      db.delete(TABLE_NAME);

      final service = SQFLiteService(TABLE_NAME, db);
      repository = ContactRepository(service);
    });

    tearDownAll(() async {
      if (db.isOpen) {
        await db.close();
      }
    });

    test('should get contacts from repository', () async {
      await repository.createContact(ContactModel());

      final contacts = await repository.getContacts();

      expect(contacts, isA<List<ContactModel>>());
    });

    test('should search contacts by name', () async {
      await repository.createContact(ContactModel(name: 'user'));

      final contacts = await repository.searchByName('user');

      expect(contacts, isA<List<ContactModel>>());
    });

    test('should get contact by id', () async {
      await repository.createContact(ContactModel());

      final contact = await repository.getContactById(1);

      expect(contact, isA<ContactModel>());
    });

    test('should update a contact', () async {
      await repository.createContact(ContactModel(name: 'person'));

      final contact = await repository.getContactById(1);
      contact!.name = 'user';

      await repository.updateContact(contact);
      final contactUpdated = await repository.getContactById(contact.id!);

      expect(contactUpdated!.name, 'user');
    });

    test('should delete a contact', () async {
      await repository.createContact(ContactModel());
      final contact = await repository.getContactById(1);

      expect(contact, isA<ContactModel>());

      await repository.deleteContact(1);
      final contactDeleted = await repository.getContactById(1);

      expect(contactDeleted, null);
    });

    test('should update a contact image', () async {
      await repository.createContact(ContactModel());
      await repository.updateImage(1, 'imagePath');

      final contactUpdated = await repository.getContactById(1);
      expect(contactUpdated!.image, 'imagePath');
    });

    test('should update a contact address', () async {
      await repository.createContact(ContactModel());
      await repository.updateAddress(
          1, 'addressLine1', 'addressLine2', 'latLng');

      final contactUpdated = await repository.getContactById(1);
      expect(contactUpdated!.addressLine1, 'addressLine1');
      expect(contactUpdated.addressLine2, 'addressLine2');
      expect(contactUpdated.latLng, 'latLng');
    });
  });
}
