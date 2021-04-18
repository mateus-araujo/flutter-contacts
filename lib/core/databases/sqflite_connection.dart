import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:contacts/core/settings/database.dart';

class SQFLiteConnection {
  late Database _sqfliteConnection;

  SQFLiteConnection._();

  static Future<SQFLiteConnection> create() async {
    var sqfliteConnection = SQFLiteConnection._();
    await sqfliteConnection._initDatabase();
    return sqfliteConnection;
  }

  Future<Database> _initDatabase() async {
    final connection = await openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
      },
      version: 1,
    );

    _sqfliteConnection = connection;

    return connection;
  }

  Database get connection => _sqfliteConnection;
}
