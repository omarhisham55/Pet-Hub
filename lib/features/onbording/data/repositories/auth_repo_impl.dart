import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/core/error/exceptions.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/internet_check.dart';
import 'package:pet_app/core/shared/constants/mixins.dart';
import 'package:pet_app/features/onbording/data/datasources/auth_datasource.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/onbording/domain/repositories/auth_repo.dart';

class AuthRepoImpl extends AuthRepo with NetworkCheckMixin {
  final AuthDatasource authDatasource;
  final NetworkInfo connection;

  AuthRepoImpl({required this.authDatasource, required this.connection});
  @override
  Future<Either<Failure, void>> createAccountWithEmail(
      String email, String password) async {
    try {
      return Right(
        await authDatasource.createAccountWithEmail(email, password),
      );
    } on FirebaseAuthException catch (e) {
      logger.e('Error while creating the account! $e');
      return Left(
        ServerFailure.fromFirebase(FirebaseExceptions.fromFirebaseException(e)),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmail(
      String email, String password) async {
    try {
      return Right(
        await authDatasource.loginWithEmail(email, password),
      );
    } on FirebaseAuthException catch (e) {
      logger.e('Error while creating the account! ${e.code} ${e.message}');
      return Left(
        ServerFailure.fromFirebase(FirebaseExceptions.fromFirebaseException(e)),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  NetworkInfo get networkInfo => this.connection;
}
