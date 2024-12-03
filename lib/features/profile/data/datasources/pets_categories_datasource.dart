import 'package:pet_app/config/services/firebase/categories_firestore.dart';
import 'package:pet_app/features/profile/domain/entities/pet_category.dart';

abstract class PetsCategoriesDatasource {
  Future<List<PetCategory>> getPetsCategories();
}

class PetsCategoriesDatasourceImpl implements PetsCategoriesDatasource {
  final CategoryFirestore categoryFirestore;

  PetsCategoriesDatasourceImpl({required this.categoryFirestore});
  @override
  Future<List<PetCategory>> getPetsCategories() async =>
      await categoryFirestore.getPetsCategories();
}
