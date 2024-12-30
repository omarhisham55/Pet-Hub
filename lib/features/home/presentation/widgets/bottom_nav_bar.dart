import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/presentation/cubit/navigation_cubit/navigation_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationCubit cubit = context.read<NavigationCubit>();
    final List<BottomNavigationBarItem> items =
        MainStrings.bottomNavbarItems.entries
            .map((item) => BottomNavigationBarItem(
                  label: item.key,
                  icon: Icon(item.value),
                ))
            .toList();

    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: cubit.changeNavbarIndex,
          items: items,
        );
      },
    );
  }
}
