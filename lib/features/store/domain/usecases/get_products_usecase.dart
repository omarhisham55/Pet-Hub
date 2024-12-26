import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/domain/repositories/product_repo.dart';

class GetProductsUsecase extends UseCase<List<Product>, ProductParams> {
  final ProductsRepo productsRepo;

  GetProductsUsecase({required this.productsRepo});
  @override
  Future<Either<Failure, List<Product>>> call(ProductParams parameter) async =>
      await productsRepo.getProducts(
        productId: parameter.productId,
        categoryId: parameter.categoryId,
        subCategoryId: parameter.subCategoryId,
      );
}

class ProductParams {
  final String? productId;
  final String? categoryId;
  final String? subCategoryId;

  ProductParams({this.productId, this.categoryId, this.subCategoryId});
}
