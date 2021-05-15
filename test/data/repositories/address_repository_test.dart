import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_test/flutter_test.dart';

import 'package:contacts/data/repositories/address_repository.dart';

main() {
  late AddressRepository repository;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv.load();

    repository = AddressRepository();
  });

  test('should return an anddress', () async {
    final response = await repository.searchAddress('Pontes Vieira 440');
    response.fold(
      (l) => print(l),
      (r) => print(r),
    );
  });
}
