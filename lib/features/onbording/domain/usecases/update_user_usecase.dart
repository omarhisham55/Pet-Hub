import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/onbording/domain/repositories/auth_repo.dart';

class UpdateUserUsecase extends OneParamUsecase<User, UserModel> {
  final AuthRepo authRepo;

  UpdateUserUsecase({required this.authRepo});
  @override
  Future<Either<Failure, User>> call(UserModel parameter) async =>
      await authRepo.updateUser(parameter);
}
