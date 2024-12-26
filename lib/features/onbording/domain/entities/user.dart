import 'package:equatable/equatable.dart';
import 'package:pet_app/features/home/data/models/pet_model.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final List<PetModel> ownedPets;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.ownedPets = const [],
  });
  @override
  List<Object?> get props => [id, email, ownedPets.length];

  String get capName => name[0].toUpperCase() + name.substring(1);
}
