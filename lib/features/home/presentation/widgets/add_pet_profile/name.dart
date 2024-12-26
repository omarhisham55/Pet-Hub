import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/text_fields/global_text_field.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/presentation/cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/body_manager.dart';

class PetNameGenderAndImage extends StatelessWidget {
  const PetNameGenderAndImage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPetBloc>();

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      behavior: HitTestBehavior.translucent,
      child: SetProfileBodyMainContent(
        title: MainStrings.addPetNameTitle,
        subTitle: MainStrings.addPetNameSubtitle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: cubit.petNameFormKey,
                child: GlobalTextField(
                  hintText: MainStrings.addPetNameHint,
                  validator: (value) =>
                      value!.isEmpty ? ErrorStrings.addPetEmptyNameError : null,
                  controller: cubit.petNameController,
                ),
              ),
              const SizedBox(height: 40),
              BlocSelector<AddPetBloc, AddPetState, bool>(
                selector: (state) => state.gender,
                builder: (context, isMale) {
                  return Row(
                    children: [
                      _radioUnit(
                        context: context,
                        state: cubit.state,
                        title: MainStrings.male,
                        value: true,
                        isMale: isMale,
                        onTap: () => cubit.add(ChangeItemEvent(item: true)),
                      ),
                      const SizedBox(width: 20),
                      _radioUnit(
                        context: context,
                        state: cubit.state,
                        title: MainStrings.female,
                        value: false,
                        isMale: !isMale,
                        onTap: () => cubit.add(ChangeItemEvent(item: false)),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioUnit({
    required BuildContext context,
    required AddPetState state,
    required String title,
    required bool isMale,
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
              color:
                  isMale ? SharedModeColors.blue500 : SharedModeColors.grey200,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<bool>(
                value: value,
                groupValue: state.gender,
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
                    .copyWith(color: isMale ? SharedModeColors.blue500 : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
