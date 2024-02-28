import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';

class AddNewPetProfile extends StatelessWidget {
  const AddNewPetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoTitleAppbar(
        context: context,
        title: 'Add Profile',
        centerTitle: true,
      ),
      body: profile(context),
      bottomSheet: GlobalButton(
        padding: const EdgeInsets.all(10),
        text: 'Add to account',
        onPressed: () =>
            ProfileSetupCubit.get(context).addNewPetProfile(context),
      ),
    );
  }

  Widget profile(BuildContext context, {bool? canEdit}) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 60),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PetProfileWidgets.petOverview(context, canEdit!),
            PetProfileWidgets.petDetails(context),
            PetProfileWidgets.importantTakes(context),
            PetProfileWidgets.caretakers(context),
          ],
        ),
      ),
    );
  }
}
