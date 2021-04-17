import 'package:contacts/core/interfaces/database/database_connection.dart';
import 'package:contacts/core/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteConnection implements DatabaseConnection {
  @override
  Future<Database> initDatabase(String databaseName) async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }
}
