part of 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/add_profile.dart';

class AddPetDetails extends StatelessWidget {
  final AddPetState state;

  const AddPetDetails({super.key, required this.state});

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
            value: MapEntry(
              MainStrings.gender,
              state.gender ? MainStrings.male : MainStrings.female,
            ),
          ),
          const Divider(),
          CustomDetailedRow(
              value: MapEntry(MainStrings.size,
                  MainStrings.sizeInfo.keys.toList()[state.carouselIndex])),
          const Divider(),
          CustomDetailedRow(value: MapEntry(MainStrings.weight, state.weight)),
        ],
      ),
    );
  }
}
