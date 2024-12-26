part of 'package:pet_app/features/store/presentation/pages/product_details_page.dart';

class SimilarProductsSection extends StatelessWidget {
  final Product product;
  const SimilarProductsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PetStoreCubit>();
    final similarProducts = cubit.state.products
        .where((p) => p.categoryId == product.categoryId)
        .toList()
      ..removeWhere((p) => p.id == product.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MainStrings.similarProductsTitle,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 10),
        if (similarProducts.isEmpty)
          ErrorWidgetAndRetry(
            errorMessage: MainStrings.noSimilarProducts,
            retryFunction: () {},
            showRetryButton: false,
          ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: similarProducts.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 160,
                child: ProductItem(
                  product: similarProducts[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
