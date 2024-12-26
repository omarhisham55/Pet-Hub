import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/presentation/cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/body_manager.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

class PetWeight extends StatelessWidget {
  const PetWeight({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPetBloc>();
    return SetProfileBodyMainContent(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      title: MainStrings.addPetWeightTitle,
      subTitle: MainStrings.addPetWeightSubtitle,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: NumericRulerScalePicker(
              controller: cubit.scalePickerController,
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
          BlocSelector<AddPetBloc, AddPetState, bool>(
            selector: (state) => state.isKg,
            builder: (context, isKg) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    _radioUnit(
                      context: context,
                      state: cubit.state,
                      title: MainStrings.kg,
                      value: true,
                      isKg: isKg,
                      onTap: () => cubit.add(ChangeItemEvent(item: true)),
                    ),
                    const SizedBox(width: 20),
                    _radioUnit(
                      context: context,
                      state: cubit.state,
                      title: MainStrings.lbs,
                      value: false,
                      isKg: !isKg,
                      onTap: () => cubit.add(ChangeItemEvent(item: false)),
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

  Widget _radioUnit({
    required BuildContext context,
    required AddPetState state,
    required String title,
    required bool isKg,
    required bool value,
    required Function() onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isKg ? SharedModeColors.blue500 : SharedModeColors.grey200,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<bool>(
                value: value,
                groupValue: state.isKg,
                toggleable: false,
                activeColor: SharedModeColors.blue500,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                onChanged: (value) => onTap(),
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: isKg ? SharedModeColors.blue500 : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
