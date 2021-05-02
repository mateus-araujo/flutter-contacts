import 'package:sqflite/sqflite.dart';

import 'package:contacts/domain/errors/errors.dart';
import 'package:contacts/domain/repositories/database_repository.dart';

class SQFLiteRepository implements IDatabaseRepository {
  final Database db;
  final String tableName;

  SQFLiteRepository(this.tableName, this.db);

  @override
  Future<int> insert(item) async {
    return await db.insert(
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
        '%$term%',
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
  Future<int> update(int id, Map<String, Object?> data) async {
    return await db.update(
      tableName,
      data,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
