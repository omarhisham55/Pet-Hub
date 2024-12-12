import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/presentation/cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile/body_manager.dart';

class AddPetProfile extends StatelessWidget {
  const AddPetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPetBloc, AddPetState>(
      builder: (context, state) {
        final AddPetBloc cubit = context.read<AddPetBloc>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: TwoTitleAppbar(
            height: 100,
            leading: GestureDetector(
              onTap: () => cubit.add(ChangeStepEvent(
                context: context,
                stepNumber: state.progress.order - 1,
              )),
              child: Icon(Icons.adaptive.arrow_back),
            ),
            centerTitle: true,
            title: MainStrings.addPetProfile,
            subTitle: state.progress.title,
            actions: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      MainStrings.step,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${state.progress.order + 1}/${AddPetStep.values.length}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 8,
                    decoration: BoxDecoration(
                      color: SharedModeColors.grey200,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  BlocBuilder<AddPetBloc, AddPetState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(24),
                          minHeight: 8,
                          value:
                              state.progress.order / AddPetStep.values.length,
                          color: SharedModeColors.yellow500,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: addPetProfileBodyContent(cubit),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: GlobalButton(
                  text: MainStrings.continueString,
                  onPressed: () => cubit.onContinueClickEvents(context),
                  color: SharedModeColors.blue500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
