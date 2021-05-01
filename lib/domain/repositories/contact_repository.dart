import 'package:dartz/dartz.dart';

import 'package:contacts/domain/entities/contact.dart';
import 'package:contacts/domain/errors/errors.dart';

abstract class IContactRepository {
  Future<Either<Failure, int>> createContact(Contact model);
  Future<Either<Failure, List<Contact>>> getContacts();
  Future<Either<Failure, List<Contact>>> searchByName(String term);
  Future<Either<Failure, Contact>> getContactById(int contactId);
  Future<Either<Failure, int>> updateContact(Contact model);
  Future<Either<Failure, int>> deleteContact(int contactId);
  Future<Either<Failure, int>> updateImage(int contactId, String imagePath);
  Future<Either<Failure, int>> updateAddress(
    int contactId,
    String addressLine1,
    String addressLine2,
    String latLng,
  );
}
