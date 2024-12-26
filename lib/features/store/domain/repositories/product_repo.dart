import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/features/store/data/models/comment_review_model.dart';
import 'package:pet_app/features/store/data/models/product_model.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/domain/entities/product_category.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<Product>>> getProducts({
    String? productId,
    String? categoryId,
    String? subCategoryId,
  });

  Future<Either<Failure, List<ProductCategory>>> getProductCategories(
      {String? id});

  Future<Either<Failure, bool>> addProduct(ProductModel product);

  Future<Either<Failure, String>> addComment(
    Product product,
    CommentReviewModel comment,
  );
}
