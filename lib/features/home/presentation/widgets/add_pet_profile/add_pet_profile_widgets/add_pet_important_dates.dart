part of 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/add_profile.dart';

class AddPetImportantDates extends StatelessWidget {
  final AddPetState state;
  const AddPetImportantDates({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MainStrings.importantDates,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        DateRow(
          context: context,
          icon: Icons.cake_outlined,
          title: MainStrings.birthday,
          date: state.birthDate,
          suffix: state.age,
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.zero,
        ),
        const Divider(),
        DateRow(
          context: context,
          icon: Icons.house_outlined,
          title: MainStrings.adoptionDay,
          date: state.adoptionDate,
          suffix: state.adoptionAge,
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.zero,
        ),
      ],
    );
  }
}
