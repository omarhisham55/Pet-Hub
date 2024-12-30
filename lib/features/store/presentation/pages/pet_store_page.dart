import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/error_and_retry.dart';
import 'package:pet_app/core/shared/components/loading_logo.dart';
import 'package:pet_app/core/shared/components/toast.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';
import 'package:pet_app/features/store/presentation/widgets/pet_store_page_widgets/product_item.dart';

part 'package:pet_app/features/store/presentation/widgets/pet_store_page_widgets/products_list.dart';
part 'package:pet_app/features/store/presentation/widgets/pet_store_page_widgets/product_category_item.dart';
part 'package:pet_app/features/store/presentation/widgets/pet_store_page_widgets/product_categories_list.dart';

class PetStorePage extends StatelessWidget {
  const PetStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PetStoreCubit, PetStoreState>(
      listener: (context, state) {
        if (state.categoriesStatus == ResponseStatus.error ||
            state.productsStatus == ResponseStatus.error) {
          showToast(text: state.errorMessage, state: ToastStates.error);
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ProductCategoryList(),
            Expanded(child: ProductList()),
          ],
        ),
      ),
    );
  }
}
