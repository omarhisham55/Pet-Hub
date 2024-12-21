import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_app/core/shared/components/appbars/appbar_with_back_button.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/shared/components/loading_logo.dart';
import 'package:pet_app/core/shared/components/text_fields/global_text_field.dart';
import 'package:pet_app/core/shared/components/toast.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/store/domain/entities/comment_review.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';
import 'package:pet_app/features/store/presentation/widgets/pet_store_page_widgets/product_item.dart';

part 'package:pet_app/features/store/presentation/widgets/product_details_widgets/comments_review_section.dart';
part 'package:pet_app/features/store/presentation/widgets/product_details_widgets/similar_products_section.dart';
part 'package:pet_app/features/store/presentation/widgets/product_details_widgets/product_details_body.dart';
part 'package:pet_app/features/store/presentation/widgets/product_details_widgets/product_details_section.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PetStoreCubit, PetStoreState>(
      listener: (context, state) {
        if (state.addCommentStatus == ResponseStatus.error) {
          showToast(text: state.errorMessage, state: ToastStates.error);
        }
        if (state.addCommentStatus == ResponseStatus.success) {
          showToast(text: state.successMessage, state: ToastStates.success);
        }
      },
      child: Scaffold(
        appBar: AppbarWithBackButton(
          title: MainStrings.productDetailAppbarTitle,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.adaptive.share),
            )
          ],
        ),
        body: ProductDetailsBody(product: product),
      ),
    );
  }
}
