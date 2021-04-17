abstract class DatabaseService {
  Future insert(Map<String, Object?> item);
  Future<List<Map<String, Object?>>> getList();
  Future<List<Map<String, Object?>>> searchTextByField(
    String field,
    String term,
  );
  Future<Map<String, Object?>> getFirstById(int id);
  Future update(int id, Map<String, Object?> data);
  Future delete(int id);
}
