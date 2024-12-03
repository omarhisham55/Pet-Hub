import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/profile/data/models/pet_model.dart';
import 'package:pet_app/features/profile/domain/entities/pet.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    super.ownedPets,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final List<Pet> pets = [];
    json['ownedPets'].forEach((pet) => pets.add(PetModel.fromJson(pet)));
    return UserModel(
      id: json['id'],
      email: json['email'],
      ownedPets: pets,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'ownedPets': ownedPets,
      };
}
