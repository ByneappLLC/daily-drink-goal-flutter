abstract class Failure {
  Failure({this.message});
  String message;
}

class DatabaseError extends Failure {}

class InsertError extends Failure {}
