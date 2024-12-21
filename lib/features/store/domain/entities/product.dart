import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:pet_app/features/store/data/models/comment_review_model.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String subCategoryId;
  final num price;
  final num rating;
  final Uint8List? image;
  final List<CommentReviewModel> commentReviews;
  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.subCategoryId,
    required this.description,
    required this.price,
    required this.rating,
    this.commentReviews = const [],
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        categoryId,
        subCategoryId,
        description,
        price,
        commentReviews.length,
      ];
}
