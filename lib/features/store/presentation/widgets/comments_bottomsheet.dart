import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pet_app/core/shared/components/dialogs/rating_dialog.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/shared/components/text_fields/global_text_field.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/store/domain/entities/comment_review.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';

Future<void> showCommentsBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext, CommentReview) item,
  required Product product,
}) async {
  final KeyboardVisibilityController _keyboardController =
      KeyboardVisibilityController();
  return await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return KeyboardVisibilityBuilder(
        controller: _keyboardController,
        builder: (context, isKeyboardVisible) {
          return Container(
            margin: isKeyboardVisible
                ? const EdgeInsets.only(bottom: 260)
                : EdgeInsets.zero,
            child: GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              child: DraggableScrollableSheet(
                expand: false,
                snap: true,
                builder: (context, scrollController) => AllCommentsReview(
                  scrollController: scrollController,
                  product: product,
                  item: item,
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class AllCommentsReview extends StatelessWidget {
  final Widget? Function(BuildContext, CommentReview) item;
  final Product product;
  final ScrollController scrollController;

  const AllCommentsReview({
    super.key,
    required this.item,
    required this.product,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PetStoreCubit, PetStoreState, List<ResponseStatus>>(
      selector: (state) => [state.addCommentStatus, state.productsStatus],
      builder: (context, state) {
        final cubit = context.read<PetStoreCubit>();
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: product.commentReviews.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) =>
                        item(context, product.commentReviews[index]),
                  ),
                ),
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
              )
            ],
          ),
        );
      },
    );
  }
}
