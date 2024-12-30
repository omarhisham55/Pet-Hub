part of 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/add_profile.dart';

class AddPetDetails extends StatelessWidget {
  final Pet pet;

  const AddPetDetails({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MainStrings.petDetailsTitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          CustomDetailedRow(
            value: MapEntry(MainStrings.gender, pet.gender),
          ),
          const Divider(),
          CustomDetailedRow(value: MapEntry(MainStrings.size, pet.size)),
          const Divider(),
          CustomDetailedRow(value: MapEntry(MainStrings.weight, pet.weight)),
        ],
      ),
    );
  }
}
