import 'package:equatable/equatable.dart';
import 'package:pet_app/features/profile/domain/entities/pet.dart';

class User extends Equatable {
  final String id;
  final String email;
  final List<Pet> ownedPets;

  User({
    required this.id,
    required this.email,
    this.ownedPets = const [],
  });
  @override
  List<Object?> get props => [id, email, ownedPets.length];
}
