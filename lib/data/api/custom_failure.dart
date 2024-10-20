class Failure {
  dynamic error;

  Failure({this.error});
}

class ConnectionFailure extends Failure {
  ConnectionFailure({super.error});
}

class ServerFailure extends Failure {
  ServerFailure({super.error});
}