abstract class Failure implements Exception {}

class InvalidTextError implements Failure {}

class DatabaseNotFound implements Failure {}

class DatabaseError implements Failure {
  final String? message;

  DatabaseError({this.message});
}
