class Failure {
  final Exception cause;

  Failure({this.cause});

  factory Failure.withCause(Exception e) {
    return Failure(cause: e);
  }
}

class UserNotRegisteredFailure extends Failure {}

class WrongPasswordFailure extends Failure {}

class ProfileNotFoundFailure extends Failure {}

class InvalidSessionFailure extends Failure {}

class UnknownSignInFailure extends Failure {
  UnknownSignInFailure({Exception cause}) : super(cause: cause);
}
