import 'package:pet_app/features/profile/domain/entities/pet.dart';

class PetModel extends Pet {
  PetModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imgUrl,
    required super.breed,
    required super.size,
    required super.weight,
    required super.birthDate,
    required super.adpotionDate,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      imgUrl: json['imgUrl'],
      breed: json['breed'],
      size: json['size'],
      weight: json['weight'],
      birthDate: json['birthDate'],
      adpotionDate: json['adoptionDate'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'category': category,
        'imgUrl': imgUrl,
        'breed': breed,
        'size': size,
        'weight': weight,
        'birthDate': birthDate,
        'adoptionDate': adpotionDate,
      };
}
