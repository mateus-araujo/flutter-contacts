import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteDatabase {
  static Future<Database> create(
      String databaseName, String databaseTableScript) async {
    final sqfliteDatabase = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(databaseTableScript);
      },
      version: 1,
    );

    return sqfliteDatabase;
  }
}
