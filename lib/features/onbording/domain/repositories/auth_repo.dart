import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> createAccountWithEmail(
    String email,
    String password,
  );
  Future<Either<Failure, User>> loginWithEmail(String email, String password);
}
