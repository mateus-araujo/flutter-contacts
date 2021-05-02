import 'package:contacts/domain/errors/errors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/device/repositories/sqflite_repository.dart';
import 'package:contacts/device/utils/contacts_database.dart';
import 'package:contacts/domain/entities/contact.dart';

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
            return db.execute(ContactsDatabase.CREATE_CONTACTS_TABLE_SCRIPT);
          },
          version: 1,
        ),
      );

      db.delete(ContactsDatabase.TABLE_NAME);

      final service = SQFLiteRepository(ContactsDatabase.TABLE_NAME, db);
      repository = ContactRepository(service);
    });

    tearDownAll(() async {
      if (db.isOpen) {
        await db.close();
      }
    });

    test('should get contacts from repository', () async {
      final data = await repository.createContact(Contact());
      final contactId = data.fold((_) => null, (r) => r);

      expect(data.isRight(), true);
      expect(contactId, isA<int>());

      final contacts = await repository.getContacts();

      final list = contacts.fold<List<Contact>?>((_) => null, (r) => r);

      expect(contacts.isRight(), true);
      expect(list, isA<List<Contact>>());
    });

    test('should search contacts by name', () async {
      await repository.createContact(Contact(name: 'user'));

      final data = await repository.searchByName('user');

      data.fold(
        (_) => null,
        (contacts) => expect(contacts, isA<List<Contact>>()),
      );
    });

    test('should get contact by id', () async {
      final data = await repository.createContact(Contact());

      data.fold((_) => null, (id) async {
        final contact = await repository.getContactById(id);

        expect(contact, isA<Contact>());
      });
    });

    test('should update a contact', () async {
      await repository.createContact(Contact(name: 'person'));

      final data = await repository.getContactById(1);
      final contact = data.fold((_) => null, (r) => r);
      contact!.name = 'user';

      await repository.updateContact(contact);

      final dataUpdated = await repository.getContactById(contact.id!);
      final contactUpdated = dataUpdated.fold((_) => null, (r) => r);

      expect(contactUpdated!.name, 'user');
    });

    test('should delete a contact', () async {
      await repository.createContact(Contact());
      final data = await repository.getContactById(1);
      final contact = data.fold((_) => null, (r) => r);

      expect(contact, isA<Contact>());

      await repository.deleteContact(1);
      final contactDeleted = await repository.getContactById(1);

      expect(contactDeleted.fold((l) => l, (r) => r), isA<Failure>());
    });

    test('should update a contact image', () async {
      await repository.createContact(Contact());
      await repository.updateImage(1, 'imagePath');

      final dataUpdated = await repository.getContactById(1);
      final contactUpdated = dataUpdated.fold((_) => null, (r) => r);
      expect(contactUpdated!.image, 'imagePath');
    });

    test('should update a contact address', () async {
      await repository.createContact(Contact());
      await repository.updateAddress(
          1, 'addressLine1', 'addressLine2', 'latLng');

      final dataUpdated = await repository.getContactById(1);
      final contactUpdated = dataUpdated.fold((_) => null, (r) => r);

      expect(contactUpdated!.addressLine1, 'addressLine1');
      expect(contactUpdated.addressLine2, 'addressLine2');
      expect(contactUpdated.latLng, 'latLng');
    });
  });
}
