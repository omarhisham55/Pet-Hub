import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';
import 'package:pet_app/features/profile/presentation/cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile/body_manager.dart';

class AddPetProfile extends StatelessWidget {
  const AddPetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPetBloc, AddPetState>(
      builder: (context, state) {
        final AddPetBloc manager = context.read();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: twoTitleAppbar(
            leading: GestureDetector(
              onTap: () => manager.add(ChangeStepEvent(
                context: context,
                stepNumber: state.progress.order - 1,
              )),
              child: Icon(Icons.adaptive.arrow_back),
            ),
            context: context,
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
          ),
          body: Column(
            children: [
              Expanded(
                child: addPetProfileBodyContent(manager),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: GlobalButton(
                  text: MainStrings.continueString,
                  onPressed: () => manager.onContinueClickEvents(context),
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
