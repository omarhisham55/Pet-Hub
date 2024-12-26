import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/shared/constants/common_functions.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constants.navigateTo(
          context,
          Routes.productDetailsPage,
          arguments: {'productId': product.id},
        );
      },
      child: Card(
        color: SharedModeColors.grey800,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: ImageHandler(
                  imageBytes: product.image,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        priceCurrency(product.price),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  RatingBar.builder(
                    initialRating: product.rating.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: SharedModeColors.yellow500,
                    ),
                    unratedColor: SharedModeColors.grey500,
                    ignoreGestures: true,
                    itemSize: 16,
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
