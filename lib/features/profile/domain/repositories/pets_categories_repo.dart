import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/features/profile/domain/entities/pet_category.dart';

abstract class PetsCategoriesRepo {
  Future<Either<Failure, List<PetCategory>>> getPetsCategories();
}
