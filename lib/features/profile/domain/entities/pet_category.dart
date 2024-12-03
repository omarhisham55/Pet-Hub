import 'package:equatable/equatable.dart';

class PetCategory extends Equatable {
  final String id;
  final String category;
  final String imgUrl;
  final List<PetBreedCategory> breeds;

  PetCategory({
    required this.id,
    required this.category,
    required this.imgUrl,
    required this.breeds,
  });
  @override
  List<Object?> get props => [id, category, breeds.length];
}

class PetBreedCategory extends Equatable {
  final String id;
  final String breed;
  final String imgUrl;

  PetBreedCategory({
    required this.id,
    required this.breed,
    required this.imgUrl,
  });
  @override
  List<Object?> get props => [id, breed];
}
