import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/body_manager.dart';

class PetName extends StatelessWidget {
  const PetName({super.key});

  @override
  Widget build(BuildContext context) {
    return SetProfileBodyMainContent(
      title: 'What\'s your pet\'s name',
      manager: ProfileSetupCubit.get(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GlobalTextField(
          hintText: 'Your pet\'s name',
          onChanged: (value) =>
              BlocProvider.of<ProfileSetupCubit>(context).nameChange(),
          controller:
              BlocProvider.of<ProfileSetupCubit>(context).petNameController,
        ),
      ),
    );
  }
}
