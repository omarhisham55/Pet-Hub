import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String id;
  final String category;
  final String imgUrl;
  final String name;
  final String breed;
  final String size;
  final String weight;
  final String birthDate;
  final String adpotionDate;

  Pet({
    required this.id,
    required this.category,
    required this.breed,
    required this.name,
    required this.imgUrl,
    required this.size,
    required this.weight,
    required this.birthDate,
    required this.adpotionDate,
  });

  @override
  List<Object?> get props => [id, name, category];
}
