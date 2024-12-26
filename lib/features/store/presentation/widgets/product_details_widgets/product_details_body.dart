part of 'package:pet_app/features/store/presentation/pages/product_details_page.dart';

class ProductDetailsBody extends StatelessWidget {
  final String productId;
  const ProductDetailsBody({super.key, required this.productId});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<PetStoreCubit>().add(GetProductsEvent(productId: productId));
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (context.read<PetStoreCubit>().initProductDetails) return;
      _onRefresh(context);
      context.read<PetStoreCubit>().initProductDetails = true;
    });
    return RefreshIndicator.adaptive(
      onRefresh: () async => _onRefresh(context),
      child: BlocConsumer<PetStoreCubit, PetStoreState>(
        listener: (context, state) {
          if (state.addCommentStatus == ResponseStatus.error) {
            showToast(text: state.errorMessage, state: ToastStates.error);
          }
          if (state.addCommentStatus == ResponseStatus.success) {
            showToast(
              text: state.successMessage,
              state: ToastStates.success,
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        },
        builder: (context, state) {
          if (state.productsStatus == ResponseStatus.loading &&
              state.addCommentStatus == ResponseStatus.initial) {
            return const LoadingLogo();
          } else if (state.productsStatus == ResponseStatus.error) {
            return ErrorWidgetAndRetry(
              errorMessage: state.errorMessage,
              retryFunction: () => _onRefresh(context),
            );
          } else {
            return GestureDetector(
              onTap: context.read<PetStoreCubit>().commentFocusNode.unfocus,
              child: ListView(
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                children: [
                  ProductDetailsSection(
                      product:
                          state.products.where((p) => p.id == productId).first),
                  Divider(),
                  CommentsReviewSection(
                      product:
                          state.products.where((p) => p.id == productId).first),
                  Divider(),
                  SimilarProductsSection(
                      product:
                          state.products.where((p) => p.id == productId).first),
                  Divider(),
                  GlobalButton(
                    text: MainStrings.addToCart,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
