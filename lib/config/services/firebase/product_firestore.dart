import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/core/shared/constants/common_functions.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/features/store/data/models/comment_review_model.dart';
import 'package:pet_app/features/store/data/models/product_model.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';

class ProductFirestore {
  final FirebaseFirestore client;

  ProductFirestore({required this.client});
  Future<List<Product>> getProducts({
    String? productId,
    String? categoryId,
    String? subCategoryId,
  }) async {
    List<Product> products = [];
    final response = await client
        .collection(Constants.firestoreProductsCollection)
        .where('id', isEqualTo: productId)
        .where('categoryId', isEqualTo: categoryId)
        .where('subCategoryId', isEqualTo: subCategoryId)
        .get();
    for (var element in response.docs) {
      final List<CommentReviewModel> comments =
          await _getComments(element.data()['id']);
      if (!isBase64(element.data()['imgUrl'])) continue;
      products.add(
        ProductModel.fromJson(element.data(), comments),
      );
    }
    return products;
  }

  Future<bool> addProduct(ProductModel product) async {
    final docRef = await client
        .collection(Constants.firestoreProductsCollection)
        .add(product.toMap());

    await docRef.update({'id': docRef.id});
    return true;
  }

  Future<List<CommentReviewModel>> _getComments(String productId) async {
    final List<CommentReviewModel> comments = [];
    final response = await client
        .collection(Constants.firestoreProductsCollection)
        .doc(productId)
        .collection(Constants.firestoreProductsCommentsAndReviewsCollection)
        .get();
    if (response.docs.isEmpty) return [];
    for (var element in response.docs) {
      if (element.data().isNotEmpty) {
        comments.add(CommentReviewModel.fromJson(element.data()));
      }
    }
    return comments;
  }

  Future<String> addComment(
      String productId, CommentReviewModel comment) async {
    final docRef = await client
        .collection(Constants.firestoreProductsCollection)
        .doc(productId)
        .collection(Constants.firestoreProductsCommentsAndReviewsCollection)
        .add(comment.toMap());
    await docRef.update({'id': docRef.id});
    return 'Comment added';
  }
}
