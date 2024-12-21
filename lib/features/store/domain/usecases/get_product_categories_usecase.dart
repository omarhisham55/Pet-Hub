import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/store/domain/entities/product_category.dart';
import 'package:pet_app/features/store/domain/repositories/product_repo.dart';

class GetProductCategoriesUsecase
    extends UseCase<List<ProductCategory>, String?> {
  final ProductsRepo productsRepo;

  GetProductCategoriesUsecase({required this.productsRepo});
  @override
  Future<Either<Failure, List<ProductCategory>>> call(String? id) async =>
      await productsRepo.getProductCategories(id: id);
}
