import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/features/appointments/presentation/pages/pet_appointment_page.dart';
import 'package:pet_app/features/health/presentation/pages/pet_health_page.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';
import 'package:pet_app/features/home/presentation/pages/home_page_profile.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';
import 'package:pet_app/features/store/presentation/pages/pet_store_page.dart';

part 'navigation_cubit_state.dart';

class NavigationCubit extends Cubit<NavigationCubitState> {
  NavigationCubit() : super(NavigationCubitInitial());

  final AdvancedDrawerController drawerScaffoldKey = AdvancedDrawerController();

  final List<Widget> pages = const [
    HomePageProfile(),
    PetHealthPage(),
    PetAppointmentPage(),
    PetStorePage(),
  ];

  void changeNavbarIndex(int index) {
    switch (index) {
      case 0:
        if (state.index == index) {
          dpi<PetProfileCubit>().getUser();
        }
      case 3:
        if (state.index == index) {
          dpi<PetStoreCubit>().add(GetProductCategoriesEvent());
        }
    }
    emit(NavbarChangeState(index));
  }
}
