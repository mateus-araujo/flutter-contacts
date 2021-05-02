abstract class Failure implements Exception {}

class DatabaseNotFound implements Failure {}

class DatabaseError implements Failure {
  final String? message;

  DatabaseError({this.message});
}

class HttpError implements Failure {}
