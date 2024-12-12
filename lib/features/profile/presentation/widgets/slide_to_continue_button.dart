import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class SlideToContinueButton extends StatelessWidget {
  const SlideToContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final profileSteupCubit = context.read<ProfileSetupCubit>();
    final addPetCubit = context.read<AddPetBloc>();
    return Stack(
      children: [
        Container(
          key: profileSteupCubit.slideToContinueKey,
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: SharedModeColors.blue100,
          ),
          child: Center(
            child: Text(
              'Swipe to continue',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: SharedModeColors.blue500),
            ),
          ),
        ),
        Draggable(
          axis: Axis.horizontal,
          onDragUpdate: (details) => details.globalPosition.dx > 340
              ? {
                  addPetCubit.add(GetCategoriesEvent()),
                  Constants.navigateTo(context, Routes.addPetProfile)
                }
              : null,
          childWhenDragging: Container(),
          feedbackOffset: Offset.infinite,
          feedback: Container(
            margin: const EdgeInsets.all(6),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: SharedModeColors.blue500,
            ),
            child: Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: SharedModeColors.white,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(6),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: SharedModeColors.blue500,
            ),
            child: Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: SharedModeColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
