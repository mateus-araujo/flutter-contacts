import 'package:contacts/data/repositories/address_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final repository = AddressRepository();

  test('should return an anddress', () async {
    final response = await repository.searchAddress('Pontes Vieira 440');
    response.fold(
      (l) => print(l),
      (r) => print(r),
    );
  });
}
