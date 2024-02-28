import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/body_manager.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

class PetWeight extends StatelessWidget {
  const PetWeight({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileSetupCubit manager = ProfileSetupCubit.get(context);
    return SetProfileBodyMainContent(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      title: "What's your pet's weight?",
      subTitle:
          "Automatic selection based on your pets breed'. Adjust according to reality.",
      manager: ProfileSetupCubit.get(context),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: NumericRulerScalePicker(
              controller: manager.scalePickerController,
              options: const RulerScalePickerOptions(
                majorIndicatorInterval: 5,
                orientation: Axis.horizontal,
                showControls: true,
              ),
              decreaseButtonBuilder: (context, action) => Container(),
              increaseButtonBuilder: (context, action) => Container(),
              valueDisplayBuilder: (context, value) => Text(
                value.toString(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: SharedModeColors.blue500,
                    ),
              ),
            ),
          ),
          BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => manager.changeUnit('kg'),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: manager.selectedUnit == 'kg'
                                  ? SharedModeColors.blue500
                                  : SharedModeColors.grey200,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: 'kg',
                                groupValue: manager.selectedUnit,
                                activeColor: SharedModeColors.blue500,
                                autofocus: true,
                                toggleable: false,
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                onChanged: (value) => manager.changeUnit(value),
                              ),
                              Text(
                                'kg',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: manager.selectedUnit == 'kg'
                                            ? SharedModeColors.blue500
                                            : null),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => manager.changeUnit('lb'),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: manager.selectedUnit == 'lb'
                                  ? SharedModeColors.blue500
                                  : SharedModeColors.grey200,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: 'lb',
                                groupValue: manager.selectedUnit,
                                toggleable: false,
                                activeColor: SharedModeColors.blue500,
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                onChanged: (value) => manager.changeUnit(value),
                              ),
                              Text(
                                'lb',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: manager.selectedUnit == 'lb'
                                            ? SharedModeColors.blue500
                                            : null),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
