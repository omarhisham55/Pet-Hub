part of 'pet_store_cubit.dart';

sealed class PetStoreEvents {}

final class GetProductCategoriesEvent extends PetStoreEvents {
  final String? id;
  GetProductCategoriesEvent({this.id});
}

final class ChangeProductCategoryEvent extends PetStoreEvents {
  final ProductCategory? category;
  final ProductSubCategory? subCategory;

  ChangeProductCategoryEvent({required this.category, this.subCategory});
}

final class GetProductsEvent extends PetStoreEvents {
  final bool isFiltering;
  final String? productId;
  final String? categoryId;
  final String? subCategoryId;

  GetProductsEvent({
    this.productId,
    this.categoryId,
    this.subCategoryId,
    this.isFiltering = false,
  });
}

final class RemoveSelectedProductEvent extends PetStoreEvents {
  final String productId;

  RemoveSelectedProductEvent({required this.productId});
}

final class AddProductEvent extends PetStoreEvents {}

final class AddCommentToProductEvent extends PetStoreEvents {
  final Product product;
  AddCommentToProductEvent({required this.product});
}
