import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class PetCategory extends Equatable {
  final String id;
  final String category;
  final Uint8List imgUrl;
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
  final Uint8List imgUrl;

  PetBreedCategory({
    required this.id,
    required this.breed,
    required this.imgUrl,
  });
  @override
  List<Object?> get props => [id, breed];
}
