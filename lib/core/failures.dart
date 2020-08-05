import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.message});

  final String message;

  @override
  List<Object> get props => <String>[message];
}

// Login Failures
class UserCanceledFailure extends Failure {
  const UserCanceledFailure({String message}) : super(message: message);
}

class CreatePreferenceFailure extends Failure {
  const CreatePreferenceFailure({String message}) : super(message: message);
}
