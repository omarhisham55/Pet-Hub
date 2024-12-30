import 'dart:convert';
import 'package:pet_app/features/store/data/models/comment_review_model.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.categoryId,
    required super.subCategoryId,
    required super.rating,
    super.commentReviews,
    super.image,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
    List<CommentReviewModel> commentReview,
  ) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      categoryId: json['categoryId'] ?? '',
      subCategoryId: json['subCategoryId'] ?? '',
      rating: json['rating'] ?? 0,
      image: json['imgUrl'] == null ? null : base64Decode(json['imgUrl']),
      commentReviews: commentReview,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'categoryId': categoryId,
        'subCategoryId': subCategoryId,
        'rating': rating,
        if (image != null) 'imgUrl': base64Encode(image!.toList()),
        'commentReviews': commentReviews.map((c) => c.toMap()).toList(),
      };
}
