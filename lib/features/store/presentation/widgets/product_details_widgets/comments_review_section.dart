part of 'package:pet_app/features/store/presentation/pages/product_details_page.dart';

class CommentsReviewSection extends StatelessWidget {
  final String productId;
  final List<CommentReview> commentReviews;
  const CommentsReviewSection(
      {super.key, required this.productId, required this.commentReviews});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PetStoreCubit, PetStoreState, ResponseStatus>(
      selector: (state) => state.addCommentStatus,
      builder: (context, state) {
        if (state == ResponseStatus.loading) {
          return LoadingLogo(height: 100);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MainStrings.commentReviewsTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              if (commentReviews.isEmpty)
                ErrorWidgetAndRetry(
                  errorMessage: MainStrings.emptyComments,
                  retryFunction: () => context
                      .read<PetStoreCubit>()
                      .add(AddCommentToProductEvent(productId: productId)),
                  // showRetryButton: false,
                ),
              if (commentReviews.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: commentReviews.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) =>
                      _buildCommentReview(context, commentReviews[index]),
                ),
              const SizedBox(height: 10),
              if (commentReviews.length > 3)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    MainStrings.seeMore,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: SharedModeColors.blue700,
                        ),
                  ),
                ),
              const SizedBox(height: 10),
              GlobalTextField(
                hintText: 'Add your comment...',
                controller: context.read<PetStoreCubit>().commentController,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentReview(
      BuildContext context, CommentReview commentReview) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: ImageHandler(
              errorImage: ProfileImages.noProfileSetup,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      commentReview.user.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      commentReview.createdAt.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                    RatingBar.builder(
                      initialRating: commentReview.rating.toDouble(),
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: SharedModeColors.yellow500,
                      ),
                      unratedColor: SharedModeColors.grey500,
                      ignoreGestures: true,
                      itemSize: 12,
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
                Text(
                  commentReview.comment,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
