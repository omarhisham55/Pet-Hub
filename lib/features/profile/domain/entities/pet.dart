import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String id;
  final String category;
  final String breed;
  final String name;
  final String gender;
  final String size;
  final String weight;
  final String age;
  final String birthDate;
  final String adoptionAge;
  final String adoptionDate;
  final Uint8List? imgUrl;

  Pet({
    required this.id,
    required this.category,
    required this.breed,
    required this.name,
    required this.gender,
    required this.size,
    required this.weight,
    required this.age,
    required this.birthDate,
    required this.adoptionAge,
    required this.adoptionDate,
    this.imgUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        breed,
        gender,
        size,
        weight,
        age,
        birthDate,
        adoptionAge,
        adoptionDate,
        imgUrl,
      ];
}
