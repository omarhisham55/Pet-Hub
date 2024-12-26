part of 'pet_store_cubit.dart';

class PetStoreState {
  final List<ProductCategory> categories;
  final List<Product> products;
  final List<Product> filteredProducts;
  final List<Product> similarProducts;
  final ResponseStatus categoriesStatus;
  final ResponseStatus productsStatus;
  final ResponseStatus addCommentStatus;
  final ProductCategory? productCategory;
  final ProductSubCategory? productSubCategory;
  final List<Product> selectedProducts;
  final String errorMessage;
  final String successMessage;

  PetStoreState({
    this.categories = const [],
    this.products = const [],
    this.filteredProducts = const [],
    this.similarProducts = const [],
    this.categoriesStatus = ResponseStatus.initial,
    this.productsStatus = ResponseStatus.initial,
    this.addCommentStatus = ResponseStatus.initial,
    this.productCategory,
    this.productSubCategory,
    this.selectedProducts = const [],
    this.errorMessage = '',
    this.successMessage = '',
  });

  PetStoreState copyWith({
    List<ProductCategory>? categories,
    List<Product>? products,
    List<Product>? filteredProducts,
    List<Product>? similarProducts,
    ResponseStatus? categoriesStatus,
    ResponseStatus? productsStatus,
    ResponseStatus? addCommentStatus,
    ProductCategory? productCategory,
    ProductSubCategory? productSubCategory,
    List<Product>? selectedProducts,
    String? errorMessage,
    String? successMessage,
    bool writeCategories = false,
  }) =>
      PetStoreState(
        categories: categories ?? this.categories,
        products: products ?? this.products,
        filteredProducts: filteredProducts ?? this.filteredProducts,
        similarProducts: similarProducts ?? this.similarProducts,
        categoriesStatus: categoriesStatus ?? this.categoriesStatus,
        productsStatus: productsStatus ?? this.productsStatus,
        addCommentStatus: addCommentStatus ?? this.addCommentStatus,
        productCategory:
            writeCategories ? productCategory : this.productCategory,
        productSubCategory:
            writeCategories ? productSubCategory : this.productSubCategory,
        selectedProducts: selectedProducts ?? this.selectedProducts,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
      );

  // @override
  // List<Object?> get props => [
  //       'categories: ${categories.length}',
  //       'products: ${products.length}',
  //       'filteredProducts: ${filteredProducts.length}',
  //       'similarProducts: ${similarProducts.length}',
  //       'categoriesStatus: $categoriesStatus',
  //       'productsStatus: $productsStatus',
  //       'addCommentStatus: $addCommentStatus',
  //       'productCategory: $productCategory',
  //       'productSubCategory: $productSubCategory',
  //       'selectedProducts: ${selectedProducts.map((e) => e.id).toList()}',
  //       'errorMessage: $errorMessage',
  //       'successMessage: $successMessage',
  //     ];
}
