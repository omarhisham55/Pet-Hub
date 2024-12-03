import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/internet_check.dart';
import 'package:pet_app/core/shared/constants/mixins.dart';
import 'package:pet_app/features/profile/data/datasources/pets_categories_datasource.dart';
import 'package:pet_app/features/profile/domain/entities/pet_category.dart';
import 'package:pet_app/features/profile/domain/repositories/pets_categories_repo.dart';

class PetsCategoriesRepoImpl extends PetsCategoriesRepo with NetworkCheckMixin {
  final NetworkInfo network;
  final PetsCategoriesDatasource petsCategoriesDatasource;

  PetsCategoriesRepoImpl(
      {required this.network, required this.petsCategoriesDatasource});
  @override
  Future<Either<Failure, List<PetCategory>>> getPetsCategories() async {
    try {
      return Right(await petsCategoriesDatasource.getPetsCategories());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  NetworkInfo get networkInfo => network;
}
