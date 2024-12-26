part of 'add_pet_to_user_bloc.dart';

sealed class AddPetEvents {}

final class ChangeStepEvent extends AddPetEvents {
  final BuildContext context;
  final int stepNumber;

  ChangeStepEvent({required this.context, required this.stepNumber});
}

final class GetCategoriesEvent extends AddPetEvents {}

final class ChangeItemEvent extends AddPetEvents {
  final Object item;
  final List<Object> extraItems;

  ChangeItemEvent({required this.item, this.extraItems = const []});
}

final class CategoryEvent extends AddPetEvents {
  final String category;

  CategoryEvent({required this.category});
}

final class BreedEvent extends AddPetEvents {
  final String breed;

  BreedEvent({required this.breed});
}

final class NameAndGenderEvent extends AddPetEvents {
  final String name;
  final bool gender;

  NameAndGenderEvent({required this.name, required this.gender});
}

final class ImageEvent extends AddPetEvents {}

final class SizeEvent extends AddPetEvents {
  final int carouselIndex;

  SizeEvent({required this.carouselIndex});
}

final class WeightEvent extends AddPetEvents {
  final String weight;
  final bool isKg;

  WeightEvent({required this.weight, this.isKg = true});
}

final class ImportantDatesEvent extends AddPetEvents {
  final String age;
  final String birthDate;
  final String adoptionAge;
  final String adoptionDate;

  ImportantDatesEvent({
    required this.age,
    required this.birthDate,
    required this.adoptionAge,
    required this.adoptionDate,
  });
}

final class CareTakerEvent extends AddPetEvents {
  final String? careTaker;

  CareTakerEvent({required this.careTaker});
}

final class AddPetToUserEvent extends AddPetEvents {}
