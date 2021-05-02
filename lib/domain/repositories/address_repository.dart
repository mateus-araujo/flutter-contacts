import 'package:dartz/dartz.dart';

import 'package:contacts/domain/errors/errors.dart';

abstract class IAddressRepository {
  Future<Either<Failure, dynamic>> searchAddress(String address);
}
