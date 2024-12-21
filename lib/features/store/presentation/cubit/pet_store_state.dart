part of 'pet_store_cubit.dart';

class PetStoreState {
  final List<ProductCategory> categories;
  final List<Product> products;
  final List<Product> filteredProducts;
  final ResponseStatus categoriesStatus;
  final ResponseStatus productsStatus;
  final ResponseStatus addCommentStatus;
  final ProductCategory? productCategory;
  final ProductSubCategory? productSubCategory;
  final String errorMessage;
  final String successMessage;

  PetStoreState({
    this.categories = const [],
    this.products = const [],
    this.filteredProducts = const [],
    this.categoriesStatus = ResponseStatus.initial,
    this.productsStatus = ResponseStatus.initial,
    this.addCommentStatus = ResponseStatus.initial,
    this.productCategory,
    this.productSubCategory,
    this.errorMessage = '',
    this.successMessage = '',
  });

  PetStoreState copyWith({
    List<ProductCategory>? categories,
    List<Product>? products,
    List<Product>? filteredProducts,
    ResponseStatus? categoriesStatus,
    ResponseStatus? productsStatus,
    ResponseStatus? addCommentStatus,
    ProductCategory? productCategory,
    ProductSubCategory? productSubCategory,
    String? errorMessage,
    String? successMessage,
    bool writeCategories = false,
  }) =>
      PetStoreState(
        categories: categories ?? this.categories,
        products: products ?? this.products,
        filteredProducts: filteredProducts ?? this.filteredProducts,
        categoriesStatus: categoriesStatus ?? this.categoriesStatus,
        productsStatus: productsStatus ?? this.productsStatus,
        addCommentStatus: addCommentStatus ?? this.addCommentStatus,
        productCategory:
            writeCategories ? productCategory : this.productCategory,
        productSubCategory:
            writeCategories ? productSubCategory : this.productSubCategory,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
      );
}
