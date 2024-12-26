import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/home/domain/entities/pet_category.dart';
import 'package:pet_app/features/home/domain/repositories/pets_categories_repo.dart';

class GetPetsCategoriesUsecase extends NoParamsUsecase<List<PetCategory>> {
  final PetsCategoriesRepo petsCategoriesRepo;

  GetPetsCategoriesUsecase({required this.petsCategoriesRepo});
  @override
  Future<Either<Failure, List<PetCategory>>> call(NoParams parameter) async =>
      await petsCategoriesRepo.getPetsCategories();
}
