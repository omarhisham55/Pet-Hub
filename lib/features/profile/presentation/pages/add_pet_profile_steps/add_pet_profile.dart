import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/body_manager.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';

class AddPetProfile extends StatelessWidget {
  const AddPetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileSetupCubit manager = ProfileSetupCubit.get(context);
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: twoTitleAppbar(
            leading: GestureDetector(
              onTap: () => manager.petProfilePrevStep(context),
              child: Icon(Icons.adaptive.arrow_back),
            ),
            context: context,
            centerTitle: true,
            title: 'Add Pet Profile',
            subTitle:
                bodyContent.keys.toList()[manager.setupPetProfileCurrentStep],
            actions: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Step',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${manager.setupPetProfileCurrentStep + 1}/${manager.setupPetProfileMaxSteps}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: addPetProfileBodyContent(manager),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: GlobalButton(
                  text: 'Continue',
                  onPressed: () {
                    bodyContent.keys
                                .toList()[manager.setupPetProfileCurrentStep] ==
                            'Name'
                        ? manager.petNameController.text.isEmpty
                            ? null
                            : manager.petProfileNextStep(context)
                        : manager.petProfileNextStep(context);
                  },
                  color: bodyContent.keys
                              .toList()[manager.setupPetProfileCurrentStep] ==
                          'Name'
                      ? manager.petNameController.text.isEmpty
                          ? SharedModeColors.white.withOpacity(.5)
                          : SharedModeColors.blue500
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
