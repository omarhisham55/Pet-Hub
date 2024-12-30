import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/date_row.dart';
import 'package:pet_app/core/shared/constants/common_functions.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/presentation/cubit/add_pet_cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/body_manager.dart';

class ImportantDates extends StatelessWidget {
  const ImportantDates({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPetBloc, AddPetState>(builder: (context, state) {
      AddPetBloc cubit = context.read<AddPetBloc>();
      return SetProfileBodyMainContent(
        title: MainStrings.addPetImportantDatesTitle,
        child: Column(
          children: [
            DateRow(
              context: context,
              icon: Icons.cake_outlined,
              title: MainStrings.birthday,
              date: cubit.state.birthDate,
              suffix: cubit.state.age,
              textColor: SharedModeColors.black,
              onTap: () => openBirthCalendar(context, (items) {
                cubit.add(ChangeItemEvent(
                  item: items[0],
                  extraItems: [
                    items[1],
                    cubit.state.adoptionDate,
                    cubit.state.adoptionAge,
                  ],
                ));
              }),
            ),
            DateRow(
              context: context,
              icon: Icons.house_outlined,
              title: MainStrings.adoptionDay,
              date: cubit.state.adoptionDate,
              suffix: cubit.state.adoptionAge,
              textColor: SharedModeColors.black,
              onTap: () => openAdoptionCalendar(context, (items) {
                cubit.add(ChangeItemEvent(
                  item: cubit.state.age,
                  extraItems: [
                    cubit.state.birthDate,
                    items[0],
                    items[1],
                  ],
                ));
              }),
            ),
          ],
        ),
      );
    });
  }
}
