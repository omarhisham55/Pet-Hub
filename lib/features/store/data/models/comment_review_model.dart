import 'package:pet_app/core/shared/constants/common_functions.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/store/domain/entities/comment_review.dart';

class CommentReviewModel extends CommentReview {
  CommentReviewModel({
    required super.id,
    required super.comment,
    required super.user,
    super.createdAt,
    required super.rating,
  });

  factory CommentReviewModel.fromJson(Map<String, dynamic> json) =>
      CommentReviewModel(
        id: json['id'],
        comment: json['comment'],
        user: UserModel.fromJson(json['user']),
        createdAt: formatDateOrRelativeTime(json['createdAt']),
        rating: json['rating'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'comment': comment,
        'user': user.toJson(),
        'rating': rating,
        'createdAt': (DateTime.now().millisecondsSinceEpoch / 1000).round(),
      };
}
