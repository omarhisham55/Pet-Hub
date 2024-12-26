part of 'add_pet_to_user_bloc.dart';

enum AddPetStep {
  category(
      order: 0, title: MainStrings.category, child: const Category()),
  breed(order: 1, title: MainStrings.breed, child: const Breed()),
  name(order: 2, title: MainStrings.name, child: const PetNameGenderAndImage()),
  size(order: 3, title: MainStrings.size, child: const PetSize()),
  weight(order: 4, title: MainStrings.weight, child: const PetWeight()),
  importantDates(
      order: 5,
      title: MainStrings.importantDates,
      child: const ImportantDates()),
  careTakers(
      order: 6, title: MainStrings.caretakers, child: const Category());

  final int order;
  final String title;
  final Widget child;
  const AddPetStep({
    required this.order,
    required this.title,
    required this.child,
  });
}
