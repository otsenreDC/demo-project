class Failure {
  final Exception cause;

  Failure({this.cause});
}

class UserNotRegisteredFailure extends Failure {}

class WrongPasswordFailure extends Failure {}

class UnknownSignInFailure extends Failure {
  UnknownSignInFailure({Exception cause}) : super(cause: cause);
}
