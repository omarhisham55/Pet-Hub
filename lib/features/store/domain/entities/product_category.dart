import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  final String id;
  final String category;
  final List<ProductSubCategory> subCategories;

  ProductCategory({
    required this.id,
    required this.category,
    required this.subCategories,
  });

  @override
  List<Object?> get props => [id, category, subCategories.length];
}

class ProductSubCategory extends Equatable {
  final String id;
  final String subCategory;

  ProductSubCategory({required this.id, required this.subCategory});

  @override
  List<Object?> get props => [id, subCategory];
}
