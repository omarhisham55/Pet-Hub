import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/internet_check.dart';
import 'package:pet_app/core/shared/constants/mixins.dart';
import 'package:pet_app/features/onbording/data/datasources/auth_datasource.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/onbording/domain/repositories/auth_repo.dart';

class AuthRepoImpl extends AuthRepo
    with NetworkCheckMixin, CheckForErrorsMixin {
  final AuthDatasource authDatasource;
  final NetworkInfo connection;

  AuthRepoImpl({required this.authDatasource, required this.connection});
  @override
  Future<Either<Failure, void>> createAccountWithEmail(
      String email, String password) async {
    return await checkNetworkConnection(
      () async => await checkFirestoreErrors(
        () async => Right(
          await authDatasource.createAccountWithEmail(email, password),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, User>> loginWithEmail(
      String email, String password) async {
    return await checkNetworkConnection(
      () async => await checkFirestoreErrors(
        () async => await Right(
          await authDatasource.loginWithEmail(email, password),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, User>> updateUser(UserModel user) async {
    return await checkNetworkConnection(
      () async => await checkFirestoreErrors(
        () async {
          final result = await authDatasource.updateUser(user);
          if (result != null) {
            return Right(result);
          }
          return Left(ServerFailure(message: 'Error getting user'));
        },
      ),
    );
  }

  @override
  NetworkInfo get networkInfo => this.connection;
}
