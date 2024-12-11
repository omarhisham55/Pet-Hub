part of 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/add_profile.dart';

class AddPetOverView extends StatelessWidget {
  final AddPetState state;
  final bool canEdit;
  const AddPetOverView({super.key, required this.state, this.canEdit = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ClipOval(
            child: ImageHandler(
              imageBytes: state.imgBytes,
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
                    state.name,
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
                  Text('${state.category} | '),
                  Text(state.breed),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
