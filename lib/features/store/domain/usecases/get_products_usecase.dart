import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/domain/repositories/product_repo.dart';

class GetProductsUsecase extends UseCase<List<Product>, List> {
  final ProductsRepo productsRepo;

  GetProductsUsecase({required this.productsRepo});
  @override
  Future<Either<Failure, List<Product>>> call(List parameter) async =>
      await productsRepo.getProducts(
        categoryId: parameter[0],
        subCategoryId: parameter[1],
      );
}
