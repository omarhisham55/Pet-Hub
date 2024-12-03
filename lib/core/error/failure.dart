import 'package:equatable/equatable.dart';
import 'package:pet_app/core/error/exceptions.dart';
import 'package:pet_app/core/utils/strings.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
  factory ServerFailure.fromFirebase(FirebaseExceptions error) {
    return ServerFailure(message: error.message);
  }

  @override
  List<Object?> get props => ['message: $message'];
}

class NoInternetConnection extends ServerFailure {
  const NoInternetConnection()
      : super(message: ErrorStrings.noInternetConnection);
}
