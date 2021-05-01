import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteConnection {
  late Database _sqfliteConnection;

  SQFLiteConnection._();

  static Future<SQFLiteConnection> create(
      String databaseName, String databaseTableScript) async {
    var sqfliteConnection = SQFLiteConnection._();
    await sqfliteConnection._initDatabase(databaseName, databaseTableScript);
    return sqfliteConnection;
  }

  Future<Database> _initDatabase(
      String databaseName, String databaseTableScript) async {
    final connection = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(databaseTableScript);
      },
      version: 1,
    );

    _sqfliteConnection = connection;

    return connection;
  }

  Database get connection => _sqfliteConnection;
}
