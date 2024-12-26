part of 'package:pet_app/features/store/presentation/pages/pet_store_page.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<PetStoreCubit>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () => _onRefresh(context),
      child: BlocBuilder<PetStoreCubit, PetStoreState>(
        builder: (context, state) {
          if (state.productsStatus == ResponseStatus.loading ||
              state.productsStatus == ResponseStatus.initial) {
            return const LoadingLogo();
          } else if (state.productsStatus == ResponseStatus.error) {
            return ErrorWidgetAndRetry(
              showErrorImg: true,
              errorMessage: state.errorMessage,
              retryFunction: () => _onRefresh(context),
            );
          }
          final List<Product> products = (state.productCategory != null ||
                  state.productSubCategory != null)
              ? state.filteredProducts
              : state.products;
          if (products.isEmpty) {
            return ErrorWidgetAndRetry(
              showErrorImg: true,
              showRetryButton: false,
              errorMessage: MainStrings.emptyProductsFilteredByCategry,
              retryFunction: () {},
            );
          } else {
            return GridView.count(
              shrinkWrap: true,
              primary: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.3,
              children: products
                  .map(
                    (product) => ProductItem(product: product),
                  )
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
