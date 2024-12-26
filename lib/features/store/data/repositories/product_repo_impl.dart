import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/internet_check.dart';
import 'package:pet_app/core/shared/constants/mixins.dart';
import 'package:pet_app/features/store/data/datasources/products_datasource.dart';
import 'package:pet_app/features/store/data/models/comment_review_model.dart';
import 'package:pet_app/features/store/data/models/product_model.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/domain/entities/product_category.dart';
import 'package:pet_app/features/store/domain/repositories/product_repo.dart';

class ProductsRepoImpl extends ProductsRepo
    with NetworkCheckMixin, CheckForErrorsMixin {
  final NetworkInfo network;
  final ProductsDatasource productsDatasource;

  ProductsRepoImpl({required this.network, required this.productsDatasource});

  @override
  Future<Either<Failure, bool>> addProduct(ProductModel product) async {
    return await checkNetworkConnection(
      () async => await checkFirestoreErrors(
        () async {
          final response = await productsDatasource.addProduct(product);
          if (response) {
            return const Right(true);
          }
          return Left(ServerFailure(message: 'Error adding product'));
        },
      ),
    );
  }

  @override
  Future<Either<Failure, List<ProductCategory>>> getProductCategories(
      {String? id}) async {
    return await checkNetworkConnection(
      () async => await checkFirestoreErrors(
        () async => Right(await productsDatasource.getCategories(id: id)),
      ),
    );
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    String? productId,
    String? categoryId,
    String? subCategoryId,
  }) async {
    return await checkNetworkConnection(
      () async => await checkFirestoreErrors(
        () async => Right(await productsDatasource.getProducts(
          productId: productId,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        )),
      ),
    );
  }

  @override
  NetworkInfo get networkInfo => network;

  @override
  Future<Either<Failure, String>> addComment(
          Product product, CommentReviewModel comment) async =>
      await checkNetworkConnection(
        () async => await checkFirestoreErrors(
          () async => Right(
            await productsDatasource.addComment(product, comment),
          ),
        ),
      );
}
