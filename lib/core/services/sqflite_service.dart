import 'package:sqflite/sqflite.dart';

import 'package:contacts/core/errors/errors.dart';
import 'package:contacts/core/interfaces/database/database_service.dart';

class SQFLiteService implements DatabaseService {
  final Database db;
  final String tableName;

  SQFLiteService(this.tableName, this.db);

  @override
  Future insert(item) async {
    await db.insert(
      tableName,
      item,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, Object?>>> getList() async {
    final maps = await db.query(tableName);

    return maps;
  }

  @override
  Future<List<Map<String, Object?>>> searchTextByField(
    String field,
    String term,
  ) async {
    final maps = await db.query(
      tableName,
      where: "$field LIKE ?",
      whereArgs: [
        '%$term',
      ],
    );

    return maps;
  }

  @override
  Future<Map<String, Object?>> getFirstById(int id) async {
    final maps = await db.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isEmpty) throw DatabaseNotFound();

    return maps.first;
  }

  @override
  Future update(int id, Map<String, Object?> data) async {
    await db.update(
      tableName,
      data,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future delete(int id) async {
    await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
