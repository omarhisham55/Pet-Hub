part of 'package:pet_app/features/store/presentation/pages/product_details_page.dart';

class CommentsReviewSection extends StatelessWidget {
  final Product product;
  const CommentsReviewSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PetStoreCubit, PetStoreState, List<ResponseStatus>>(
      selector: (state) => [state.addCommentStatus, state.productsStatus],
      builder: (context, state) {
        final cubit = context.read<PetStoreCubit>();
        if (state.any((s) => s == ResponseStatus.loading)) {
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
              if (product.commentReviews.isEmpty)
                ErrorWidgetAndRetry(
                  errorMessage: MainStrings.emptyComments,
                  retryFunction: () {},
                  showRetryButton: false,
                ),
              if (product.commentReviews.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: product.commentReviews.length > 3
                      ? 3
                      : product.commentReviews.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) => _buildCommentReview(
                      context, product.commentReviews[index]),
                ),
              const SizedBox(height: 10),
              if (product.commentReviews.length > 3)
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () => showCommentsBottomSheet(
                      context: context,
                      product: product,
                      item: _buildCommentReview,
                    ),
                    child: Text(
                      MainStrings.seeMore,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: SharedModeColors.blue700,
                          ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GlobalTextField(
                      focusNode: cubit.commentFocusNode,
                      controller: cubit.commentController,
                      hintText: MainStrings.addCommentHint,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                      onPressed: () {
                        cubit.commentFocusNode.unfocus();
                        if (cubit.commentController.text.isNotEmpty) {
                          showRatingDialog(
                              context: context,
                              onRatingComplete: () {
                                cubit.add(
                                  AddCommentToProductEvent(product: product),
                                );
                                Constants.pop(context);
                              });
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
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
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: SharedModeColors.grey500),
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
