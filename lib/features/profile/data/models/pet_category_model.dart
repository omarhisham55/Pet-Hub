import 'dart:convert';
import 'package:pet_app/features/profile/domain/entities/pet_category.dart';

class PetCategoryModel extends PetCategory {
  PetCategoryModel({
    required super.id,
    required super.category,
    required super.imgUrl,
    required super.breeds,
  });

  factory PetCategoryModel.fromJson(
          Map<String, dynamic> json, List<PetBreedCategory> breed) =>
      PetCategoryModel(
        id: json['id'],
        category: json['category'],
        imgUrl: base64Decode(json['imgUrl']),
        breeds: breed,
      );
}

class PetBreedCategoryModel extends PetBreedCategory {
  PetBreedCategoryModel({
    required super.id,
    required super.breed,
    required super.imgUrl,
  });

  factory PetBreedCategoryModel.fromJson(Map<String, dynamic> json) =>
      PetBreedCategoryModel(
        id: json['id'],
        breed: json['breed'],
        imgUrl: base64Decode(json['imgUrl']),
      );
}
