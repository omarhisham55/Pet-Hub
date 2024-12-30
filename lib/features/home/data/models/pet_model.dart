import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:pet_app/features/home/domain/entities/pet.dart';

class PetModel extends Pet {
  PetModel({
    required super.id,
    required super.name,
    required super.category,
    required super.breed,
    required super.size,
    required super.gender,
    required super.weight,
    required super.age,
    required super.birthDate,
    required super.adoptionAge,
    required super.adoptionDate,
    super.imgUrl,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      breed: json['breed'],
      size: json['size'],
      age: json['age'],
      gender: json['gender'],
      weight: json['weight'],
      birthDate: json['birthDate'],
      adoptionAge: json['adoptionAge'],
      adoptionDate: json['adoptionDate'],
      imgUrl: json['imgUrl'] == null ? null : base64Decode(json['imgUrl']),
    );
  }

  Future<Uint8List> toBytes(XFile img) async {
    return await File(img.path).readAsBytes();
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'category': category,
        'breed': breed,
        'size': size,
        'gender': gender,
        'weight': weight,
        'age': age,
        'birthDate': birthDate,
        'adoptionAge': adoptionAge,
        'adoptionDate': adoptionDate,
        if (imgUrl != null) 'imgUrl': base64Encode(imgUrl!.toList()),
      };
}
