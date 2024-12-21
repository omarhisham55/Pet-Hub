part of 'package:pet_app/features/store/presentation/pages/product_details_page.dart';

class SimilarProductsSection extends StatelessWidget {
  final Product product;
  const SimilarProductsSection({super.key, required this.product});

  void _getSimilarProducts(PetStoreCubit cubit) {
    cubit.add(GetProductsEvent(
      isFiltering: true,
      categoryId: product.categoryId,
      subCategoryId: product.subCategoryId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PetStoreCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSimilarProducts(cubit);
    });
    return BlocSelector<PetStoreCubit, PetStoreState, ResponseStatus>(
      selector: (state) => state.productsStatus,
      builder: (context, state) {
        if (state == ResponseStatus.loading) {
          return LoadingLogo(height: 100);
        } else if (state == ResponseStatus.error) {
          return ErrorWidgetAndRetry(
            errorMessage: cubit.state.errorMessage,
            retryFunction: () => _getSimilarProducts(cubit),
          );
        } else {
          final List<Product> products = cubit.state.filteredProducts
            ..remove(product);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MainStrings.similarProductsTitle,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              if (products.isEmpty)
                ErrorWidgetAndRetry(
                  errorMessage: MainStrings.noSimilarProducts,
                  retryFunction: () {},
                  showRetryButton: false,
                ),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 160,
                      child: ProductItem(
                        product: products[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
