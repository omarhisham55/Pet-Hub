import 'package:pet_app/config/services/firebase/categories_firestore.dart';
import 'package:pet_app/config/services/firebase/product_firestore.dart';
import 'package:pet_app/features/store/data/models/comment_review_model.dart';
import 'package:pet_app/features/store/data/models/product_model.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/domain/entities/product_category.dart';

abstract class ProductsDatasource {
  Future<List<Product>> getProducts({
    String? productId,
    String? categoryId,
    String? subCategoryId,
  });
  Future<List<ProductCategory>> getCategories({String? id});
  Future<bool> addProduct(ProductModel product);
  Future<String> addComment(Product product, CommentReviewModel comment);
}

class ProductsDatasourceImpl implements ProductsDatasource {
  final CategoryFirestore categoryFirestore;
  final ProductFirestore productFirestore;

  ProductsDatasourceImpl({
    required this.categoryFirestore,
    required this.productFirestore,
  });
  @override
  Future<List<ProductCategory>> getCategories({String? id}) async =>
      await categoryFirestore.getProductCategories(id: id);

  @override
  Future<List<Product>> getProducts({
    String? productId,
    String? categoryId,
    String? subCategoryId,
  }) async =>
      await productFirestore.getProducts(
        productId: productId,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  @override
  Future<bool> addProduct(ProductModel product) async =>
      await productFirestore.addProduct(product);

  @override
  Future<String> addComment(
          Product product, CommentReviewModel comment) async =>
      await productFirestore.addComment(product, comment);
}
