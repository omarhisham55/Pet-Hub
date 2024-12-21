part of 'package:pet_app/features/store/presentation/pages/product_details_page.dart';

class ProductDetailsBody extends StatelessWidget {
  final Product product;
  const ProductDetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      children: [
        ProductDetailsSection(product: product),
        const Divider(),
        CommentsReviewSection(
          productId: product.id,
          commentReviews: product.commentReviews,
        ),
        const Divider(),
        SimilarProductsSection(product: product),
      ],
    );
  }
}
