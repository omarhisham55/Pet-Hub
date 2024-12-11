part of 'add_pet_to_user_bloc.dart';

class AddPetState {
  final AddPetStep progress;
  final String category;
  final String breed;
  final String name;
  final bool gender;
  final int carouselIndex;
  final String weight;
  final bool isKg;
  final String age;
  final String birthDate;
  final String adoptionAge;
  final String adoptionDate;
  final String? careTakers;
  final Uint8List? imgBytes;
  final ResponseStatus? responseStatus;
  final String? messageError;

  AddPetState({
    required this.progress,
    this.category = '',
    this.breed = '',
    this.name = '',
    this.gender = true,
    this.carouselIndex = 0,
    this.weight = '',
    this.isKg = true,
    this.age = '',
    this.birthDate = '',
    this.adoptionAge = '',
    this.adoptionDate = '',
    this.careTakers,
    this.imgBytes,
    this.responseStatus,
    this.messageError,
  });

  void printState() => logger.f(
        "AddPetState(\n$progress, \n$category, \n$breed, \n$name, \n$carouselIndex, \n$weight, \n$isKg, \n$age, \n$birthDate, \n$adoptionAge, \n$adoptionDate, \n$careTakers, \n$responseStatus, \n$messageError, \n$imgBytes)",
      );

  clear() => AddPetState(progress: AddPetStep.category);

  AddPetState copyWith({
    AddPetStep? progress,
    String? category,
    String? breed,
    String? name,
    bool? gender,
    int? carouselIndex,
    String? weight,
    bool? isKg,
    String? age,
    String? birthDate,
    String? adoptionAge,
    String? adoptionDate,
    String? careTakers,
    Uint8List? imgBytes,
    ResponseStatus? responseStatus,
    String? messageError,
  }) =>
      AddPetState(
        progress: progress ?? this.progress,
        category: category ?? this.category,
        breed: breed ?? this.breed,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        carouselIndex: carouselIndex ?? this.carouselIndex,
        weight: weight ?? this.weight,
        isKg: isKg ?? this.isKg,
        age: age ?? this.age,
        birthDate: birthDate ?? this.birthDate,
        adoptionAge: adoptionAge ?? this.adoptionAge,
        adoptionDate: adoptionDate ?? this.adoptionDate,
        careTakers: careTakers ?? this.careTakers,
        imgBytes: imgBytes ?? this.imgBytes,
        responseStatus: responseStatus,
        messageError: messageError,
      );
}
