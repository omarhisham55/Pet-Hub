part of 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/add_profile.dart';

class AddPetOverView extends StatelessWidget {
  final Pet pet;
  final bool canEdit;
  const AddPetOverView({super.key, required this.pet, this.canEdit = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ClipOval(
            child: ImageHandler(
              imageBytes: pet.imgUrl,
              errorImage: ProfileImages.noProfileSetup,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    pet.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Visibility(
                    visible: canEdit,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: SharedModeColors.blue500),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('${pet.category} | '),
                  Text(pet.breed),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
