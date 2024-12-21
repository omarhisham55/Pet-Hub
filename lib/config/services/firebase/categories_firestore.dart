import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/features/profile/data/models/pet_category_model.dart';
import 'package:pet_app/features/profile/domain/entities/pet_category.dart';
import 'package:pet_app/features/store/data/models/product_category_model.dart';
import 'package:pet_app/features/store/domain/entities/product_category.dart';

class CategoryFirestore {
  final FirebaseFirestore _client;

  CategoryFirestore({required FirebaseFirestore client}) : _client = client;

  bool _isValidPetCategory(Map<String, dynamic> json) {
    return json['id'] != null &&
        (json['category'] != null || json['breed'] != null) &&
        json['imgUrl'] != null;
  }

  Future<List<PetCategory>> getPetsCategories() async {
    final List<PetCategory> pets = [];
    final response =
        await _client.collectionGroup(Constants.firestorePetsCollection).get();
    for (var element in response.docs) {
      if (_isValidPetCategory(element.data())) {
        final petData = element.data();
        final subItems = await _fetchSubcollection(element.reference);
        final pet = PetCategoryModel.fromJson(petData, subItems);
        pets.add(pet);
      }
    }
    return pets;
  }

  Future<List<PetBreedCategory>> _fetchSubcollection(
      DocumentReference petRef) async {
    final List<PetBreedCategory> subItems = [];
    final response =
        await petRef.collection(Constants.firestorePetsBreedsCollection).get();
    for (var element in response.docs) {
      if (_isValidPetCategory(element.data())) {
        subItems.add(PetBreedCategoryModel.fromJson(element.data()));
      }
    }
    return subItems;
  }

  Future<List<ProductCategory>> getProductCategories({String? id}) async {
    List<ProductCategory> categories = [];
    final response = await _client
        .collection(Constants.firestoreCategoriesCollection)
        .where('type', isEqualTo: 'products')
        .where('id', isEqualTo: id)
        .get();
    for (var e in response.docs.first
        .data()[Constants.firestoreCategoriesCollection]) {
      categories.add(ProductCategoryModel.fromJson(e));
    }
    return categories;
  }
}
