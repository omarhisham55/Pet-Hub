import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/profile/data/models/pet_model.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.ownedPets,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final List<PetModel> pets = [];
    json['ownedPets'].forEach((pet) => pets.add(PetModel.fromJson(pet)));
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      ownedPets: pets,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'ownedPets': ownedPets.map((pet) => pet.toMap()).toList(),
      };
}
