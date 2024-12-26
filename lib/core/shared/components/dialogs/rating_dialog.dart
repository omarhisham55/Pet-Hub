import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';

Future<void> showRatingDialog({
  required BuildContext context,
  required Function() onRatingComplete,
}) async =>
    await showAdaptiveDialog(
      context: context,
      builder: (context) => RatingDialog(onRatingComplete: onRatingComplete),
    );

class RatingDialog extends StatelessWidget {
  final Function() onRatingComplete;
  const RatingDialog({super.key, required this.onRatingComplete});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              MainStrings.ratingDialogTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
                direction: Axis.horizontal,
                allowHalfRating: true,
                glow: false,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: SharedModeColors.yellow500,
                    ),
                unratedColor: SharedModeColors.grey500,
                minRating: 1,
                updateOnDrag: true,
                onRatingUpdate: (rating) {
                  dpi<PetStoreCubit>().commentRating = rating;
                }),
            GlobalButton(
              text: MainStrings.submit,
              onPressed: onRatingComplete,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
          ],
        ),
      ),
    );
  }
}
