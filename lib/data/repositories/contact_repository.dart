import 'package:dartz/dartz.dart';

import 'package:contacts/domain/entities/contact.dart';
import 'package:contacts/domain/errors/errors.dart';
import 'package:contacts/domain/repositories/contact_repository.dart';
import 'package:contacts/domain/repositories/database_repository.dart';

class ContactRepository implements IContactRepository {
  DatabaseRepository service;
  ContactRepository(this.service);

  @override
  Future<Either<Failure, int>> createContact(Contact model) async {
    try {
      final id = await service.insert(model.toMap());

      return Right(id);
    } catch (e) {
      print(e);
      return Left(DatabaseError());
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getContacts() async {
    try {
      final maps = await service.getList();

      final list = List.generate(
        maps.length,
        (index) => Contact.fromMap(maps[index]),
      );

      return Right(list);
    } catch (e) {
      return Left(DatabaseError());
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> searchByName(String term) async {
    try {
      final maps = await service.searchTextByField('name', term);

      final list = List.generate(
        maps.length,
        (index) => Contact.fromMap(maps[index]),
      );

      return Right(list);
    } catch (e) {
      return Left(DatabaseError());
    }
  }

  @override
  Future<Either<Failure, Contact>> getContactById(int id) async {
    try {
      final map = await service.getFirstById(id);
      final contact = Contact.fromMap(map);

      return Right(contact);
    } catch (e) {
      return Left(DatabaseError());
    }
  }

  @override
  Future<Either<Failure, int>> updateContact(Contact model) async {
    try {
      final id = await service.update(model.id!, model.toMap());

      return Right(id);
    } catch (e) {
      return Left(DatabaseError());
    }
  }

  @override
  Future<Either<Failure, int>> deleteContact(int contactId) async {
    try {
      final id = await service.delete(contactId);

      return Right(id);
    } catch (e) {
      return Left(DatabaseError());
    }
  }

  @override
  Future<Either<Failure, int>> updateImage(
      int contactId, String imagePath) async {
    try {
      final data = await getContactById(contactId);
      final contact = data.fold((_) => null, (r) => r);

      contact!.image = imagePath;

      final id = await service.update(contactId, contact.toMap());

      return Right(id);
    } catch (e) {
      return Left(DatabaseError());
    }
  }

  @override
  Future<Either<Failure, int>> updateAddress(int contactId, String addressLine1,
      String addressLine2, String latLng) async {
    try {
      final data = await getContactById(contactId);
      final contact = data.fold((_) => null, (r) => r);

      contact!.addressLine1 = addressLine1;
      contact.addressLine2 = addressLine2;
      contact.latLng = latLng;

      final id = await service.update(contactId, contact.toMap());

      return Right(id);
    } catch (e) {
      return Left(DatabaseError());
    }
  }
}
