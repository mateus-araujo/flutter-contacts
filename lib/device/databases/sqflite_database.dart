import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteDatabase {
  late Database _sqfliteDatabase;

  SQFLiteDatabase._();

  static Future<SQFLiteDatabase> create(
      String databaseName, String databaseTableScript) async {
    var sqfliteConnection = SQFLiteDatabase._();
    await sqfliteConnection._initDatabase(databaseName, databaseTableScript);
    return sqfliteConnection;
  }

  Future<Database> _initDatabase(
      String databaseName, String databaseTableScript) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(databaseTableScript);
      },
      version: 1,
    );

    _sqfliteDatabase = database;

    return database;
  }

  Database get database => _sqfliteDatabase;
}
