import 'package:pet_app/features/store/domain/entities/product_category.dart';

class ProductCategoryModel extends ProductCategory {
  ProductCategoryModel({
    required super.id,
    required super.category,
    required super.subCategories,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    final List<ProductSubCategoryModel> categories = [];
    json['subCategories'].forEach((category) =>
        categories.add(ProductSubCategoryModel.fromJson(category)));
    return ProductCategoryModel(
      id: json['id'],
      category: json['category'],
      subCategories: categories,
    );
  }
}

class ProductSubCategoryModel extends ProductSubCategory {
  ProductSubCategoryModel({required super.id, required super.subCategory});

  factory ProductSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductSubCategoryModel(
      id: json['id'],
      subCategory: json['subCategory'],
    );
  }
}
