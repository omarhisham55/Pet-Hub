import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileSetupCubit cubit = context.read<ProfileSetupCubit>();
    final List<BottomNavigationBarItem> items =
        MainStrings.bottomNavbarItems.entries
            .map((item) => BottomNavigationBarItem(
                  label: item.key,
                  icon: Icon(item.value),
                ))
            .toList();

    return BlocSelector<ProfileSetupCubit, ProfileSetupState, int>(
      selector: (state) => cubit.currentBottomSheetIndex,
      builder: (context, index) {
        return BottomNavigationBar(
          currentIndex: index,
          onTap: cubit.changeBottomSheet,
          items: items,
        );
      },
    );
  }
}
