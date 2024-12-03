import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/onbording/domain/repositories/auth_repo.dart';

class CreateAccountUsecase extends MultiParamUsecase<void, List<String>> {
  final AuthRepo authRepo;

  CreateAccountUsecase({required this.authRepo});
  @override
  Future<Either<Failure, void>> call(List<String> parameter) async =>
      await authRepo.createAccountWithEmail(parameter[0], parameter[1]);
}
