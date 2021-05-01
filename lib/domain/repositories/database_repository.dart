abstract class DatabaseRepository {
  Future<int> insert(Map<String, Object?> item);
  Future<List<Map<String, Object?>>> getList();
  Future<List<Map<String, Object?>>> searchTextByField(
    String field,
    String term,
  );
  Future<Map<String, Object?>> getFirstById(int id);
  Future<int> update(int id, Map<String, Object?> data);
  Future<int> delete(int id);
}
