import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_app/core/shared/components/appbars/appbar_with_back_button.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/components/dialogs/rating_dialog.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/shared/components/loading_logo.dart';
import 'package:pet_app/core/shared/components/text_fields/global_text_field.dart';
import 'package:pet_app/core/shared/components/toast.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/store/domain/entities/comment_review.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';
import 'package:pet_app/features/store/presentation/widgets/comments_bottomsheet.dart';
import 'package:pet_app/features/store/presentation/widgets/pet_store_page_widgets/product_item.dart';

part 'package:pet_app/features/store/presentation/widgets/product_details_widgets/comments_review_section.dart';
part 'package:pet_app/features/store/presentation/widgets/product_details_widgets/similar_products_section.dart';
part 'package:pet_app/features/store/presentation/widgets/product_details_widgets/product_details_body.dart';
part 'package:pet_app/features/store/presentation/widgets/product_details_widgets/product_details_section.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWithBackButton(
        title: MainStrings.productDetailAppbarTitle,
        onBack: () => context
            .read<PetStoreCubit>()
            .add(RemoveSelectedProductEvent(productId: productId)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.adaptive.share),
          )
        ],
      ),
      body: ProductDetailsBody(productId: productId),
    );
  }
}
