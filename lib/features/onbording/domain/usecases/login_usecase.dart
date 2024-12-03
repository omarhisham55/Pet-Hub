import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/onbording/domain/repositories/auth_repo.dart';

class LoginUsecase extends MultiParamUsecase<User, List<String>> {
  final AuthRepo authRepo;

  LoginUsecase({required this.authRepo});
  @override
  Future<Either<Failure, User>> call(List<String> parameter) async =>
      await authRepo.loginWithEmail(parameter[0], parameter[1]);
}
