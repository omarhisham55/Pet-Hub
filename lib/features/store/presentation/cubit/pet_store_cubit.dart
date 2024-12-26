import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/services/di/dpi.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/home/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/store/data/models/comment_review_model.dart';
import 'package:pet_app/features/store/domain/entities/product.dart';
import 'package:pet_app/features/store/domain/entities/product_category.dart';
import 'package:pet_app/features/store/domain/usecases/add_comment_to_product_usecase.dart';
import 'package:pet_app/features/store/domain/usecases/add_product_usecase.dart';
import 'package:pet_app/features/store/domain/usecases/get_product_categories_usecase.dart';
import 'package:pet_app/features/store/domain/usecases/get_products_usecase.dart';

part 'pet_store_state.dart';
part 'pet_store_event.dart';

class PetStoreCubit extends Bloc<PetStoreEvents, PetStoreState> {
  final GetProductsUsecase getProductsUsecase;
  final GetProductCategoriesUsecase getProductCategoriesUsecase;
  final AddProductUsecase addProductsUsecase;
  final AddCommentToProductUsecase addCommentToProductUsecase;
  PetStoreCubit(
    this.getProductsUsecase,
    this.getProductCategoriesUsecase,
    this.addProductsUsecase,
    this.addCommentToProductUsecase,
  ) : super(PetStoreState()) {
    on<PetStoreEvents>(
      (event, emit) async => switch (event) {
        ChangeProductCategoryEvent() => _changeProductCategory(event, emit),
        GetProductCategoriesEvent() => await _getProductCategories(event, emit),
        GetProductsEvent() => await _getProducts(event, emit),
        RemoveSelectedProductEvent() =>
          await _removeSelectedProduct(event, emit),
        AddProductEvent() => await _addProduct(emit),
        AddCommentToProductEvent() => await _addComment(event, emit)
      },
    );
  }

  // final PagingController<int, Product> pagingController =
  //     PagingController<int, Product>(firstPageKey: 1);
  final FocusNode commentFocusNode = FocusNode();
  final TextEditingController commentController = TextEditingController();
  double commentRating = 0;
  bool initProductDetails = false;

  void _changeProductCategory(
      ChangeProductCategoryEvent event, Emitter<PetStoreState> emit) {
    if (state.productCategory == event.category &&
        state.productSubCategory == null &&
        event.subCategory == null) return;
    emit(state.copyWith(
      writeCategories: true,
      productCategory: event.category,
      productSubCategory: event.subCategory,
    ));
    add(GetProductsEvent(
      isFiltering: true,
      categoryId: state.productCategory?.id,
      subCategoryId: state.productSubCategory?.id,
    ));
  }

  Future<void> _getProductCategories(
      GetProductCategoriesEvent event, Emitter<PetStoreState> emit) async {
    emit(state.copyWith(categoriesStatus: ResponseStatus.loading));
    final result = await getProductCategoriesUsecase(event.id);
    emit(result.fold(
      (failure) => state.copyWith(
          errorMessage: failure.message,
          categoriesStatus: ResponseStatus.error),
      (categories) => state.copyWith(
          categories: categories, categoriesStatus: ResponseStatus.success),
    ));
    add(GetProductsEvent());
  }

  Future<void> _getProducts(
      GetProductsEvent event, Emitter<PetStoreState> emit) async {
    emit(state.copyWith(productsStatus: ResponseStatus.loading));
    final result = await getProductsUsecase(ProductParams(
      productId: event.productId,
      categoryId: event.categoryId,
      subCategoryId: event.subCategoryId,
    ));
    emit(result.fold(
      (failure) => state.copyWith(
          errorMessage: failure.message, productsStatus: ResponseStatus.error),
      (products) {
        final selectedProduct = _getSelectedProduct(event.productId);
        logger.f('selectedProduct: ${selectedProduct}');
        return event.isFiltering
            ? state.copyWith(
                filteredProducts: products,
                similarProducts: [],
                selectedProducts: [],
                productsStatus: ResponseStatus.success,
              )
            : event.productId != null
                ? state.copyWith(
                    selectedProducts: selectedProduct != null
                        ? (List.from(state.selectedProducts)
                          ..add(selectedProduct))
                        : [],
                    similarProducts: _getSimilarProducts(
                        _getSelectedProduct(event.productId)),
                    productsStatus: ResponseStatus.success,
                  )
                : state.copyWith(
                    products: products,
                    filteredProducts: [],
                    similarProducts: [],
                    selectedProducts: [],
                    productsStatus: ResponseStatus.success,
                  );
      },
    ));
    logger.t('${state.selectedProducts.map((p) => p.id).toList()}');
    emit(state.copyWith(addCommentStatus: ResponseStatus.initial));
  }

  _removeSelectedProduct(
      RemoveSelectedProductEvent event, Emitter<PetStoreState> emit) {
    emit(state.copyWith(
        selectedProducts: state.selectedProducts
          ..removeWhere((p) => p.id == event.productId)));
    logger.i('${state.selectedProducts.map((p) => p.id).toList()}');
  }

  Product? _getSelectedProduct(String? productId) {
    return state.products.where((p) => p.id == productId).firstOrNull;
  }

  List<Product> _getSimilarProducts(Product? product) {
    if (product == null) return [];
    return state.products
        .where((p) => p.categoryId == product.categoryId)
        .toList()
      ..removeWhere((p) => p.id == product.id);
  }

  Future<void> _addComment(
      AddCommentToProductEvent event, Emitter<PetStoreState> emit) async {
    emit(state.copyWith(addCommentStatus: ResponseStatus.loading));
    final result = await addCommentToProductUsecase([
      event.product,
      CommentReviewModel(
        id: '',
        comment: commentController.text,
        user: dpi<ProfileSetupCubit>().user as UserModel,
        rating: commentRating,
      )
    ]);
    emit(result.fold(
      (failure) => state.copyWith(
        errorMessage: failure.message,
        addCommentStatus: ResponseStatus.error,
      ),
      (successString) {
        commentController.clear();
        commentRating = 0;
        return state.copyWith(
          addCommentStatus: ResponseStatus.success,
          successMessage: successString,
        );
      },
    ));
    add(GetProductsEvent(productId: event.product.id));
  }

  Future<void> _addProduct(Emitter<PetStoreState> emit) async {
    // emit(state.copyWith(productsStatus: ResponseStatus.loading));
    // for (var e in pp) {
    //   final result = await addProductsUsecase(e);
    //   emit(result.fold(
    //     (failure) => state.copyWith(
    //         errorMessage: failure.message,
    //         productsStatus: ResponseStatus.error),
    //     (r) => state.copyWith(
    //         productsStatus: ResponseStatus.success,
    //         errorMessage: 'product added'),
    //   ));
    // }
  }
}
