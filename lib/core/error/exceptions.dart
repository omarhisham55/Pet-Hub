import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_app/core/utils/strings.dart';

class ServerExceptions implements Exception {}

class FirebaseExceptions implements Exception, Equatable {
  final String code;
  final String message;
  FirebaseExceptions({required this.code, required this.message});

  factory FirebaseExceptions.fromFirebaseException(Exception exception) {
    if (exception is FirebaseAuthException) {
      return FirebaseExceptions(
        code: exception.code,
        message: _authErrorMessage(exception.code),
      );
    } else if (exception is FirebaseException) {
      return FirebaseExceptions(
        code: exception.code,
        message: _firestoreErrorMessage(exception.code),
      );
    } else {
      return FirebaseExceptions(code: 'unknown', message: ErrorStrings.unknown);
    }
  }

  /// Maps error codes to user-friendly messages for Firebase Authentication
  static String _authErrorMessage(String code) {
    const authErrorMapping = {
      'email-already-in-use': ErrorStrings.emailAlreadyInUse,
      'user-not-found': ErrorStrings.userNotFound,
      'wrong-password': ErrorStrings.wrongPassword,
      'weak-password': ErrorStrings.weakPassword,
      'invalid-email': ErrorStrings.invalidEmail,
      'user-disabled': ErrorStrings.userDisabled,
      'invalid-credential': ErrorStrings.invalidCredential,
    };
    return authErrorMapping[code] ?? ErrorStrings.unknown;
  }

  /// Maps error codes to user-friendly messages for Firestore
  static String _firestoreErrorMessage(String code) {
    const firestoreErrorMapping = {
      'unknown': ErrorStrings.unknown,
      'operation-not-allowed': ErrorStrings.operationNotAllowed,
      'permission-denied': ErrorStrings.permissionDenied,
      'cancelled': ErrorStrings.cancelled,
      'invalid-argument': ErrorStrings.invalidArgument,
      'not-found': ErrorStrings.notFound,
      'already-exists': ErrorStrings.alreadyExists,
      'deadline-exceeded': ErrorStrings.deadlineExceeded,
      'resource-exhausted': ErrorStrings.resourceExhausted,
      'failed-precondition': ErrorStrings.failedPrecondition,
      'aborted': ErrorStrings.aborted,
      'out-of-range': ErrorStrings.outOfRange,
      'unimplemented': ErrorStrings.unimplemented,
      'internal': ErrorStrings.internal,
      'unavailable': ErrorStrings.unavailable,
      'data-loss': ErrorStrings.dataLoss,
    };
    return firestoreErrorMapping[code] ?? ErrorStrings.unknown;
  }

  @override
  List<Object?> get props => ['code: $code', 'message: $message'];

  @override
  bool? get stringify => true;
}
