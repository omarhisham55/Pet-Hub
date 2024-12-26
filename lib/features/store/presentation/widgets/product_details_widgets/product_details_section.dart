part of 'package:pet_app/features/store/presentation/pages/product_details_page.dart';

class ProductDetailsSection extends StatelessWidget {
  final Product product;
  const ProductDetailsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PetStoreCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: ImageHandler(imageBytes: product.image)),
        const SizedBox(height: 20),
        Text(
          product.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: SharedModeColors.grey500),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                cubit.state.categories
                    .where((category) => category.id == product.categoryId)
                    .first
                    .category
                    .toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: SharedModeColors.grey500),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                cubit.state.categories
                    .where((category) => category.id == product.categoryId)
                    .first
                    .subCategories
                    .where((category) => category.id == product.subCategoryId)
                    .first
                    .subCategory
                    .toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Spacer(),
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
        const SizedBox(height: 10),
      ],
    );
  }
}
