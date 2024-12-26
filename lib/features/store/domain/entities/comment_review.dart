import 'package:pet_app/features/onbording/data/models/user_model.dart';

class CommentReview {
  final String id;
  final String comment;
  final UserModel user;
  final String createdAt;
  final num rating;

  CommentReview({
    required this.id,
    required this.comment,
    required this.user,
    this.createdAt = '',
    required this.rating,
  });
}
