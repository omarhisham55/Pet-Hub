import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/config/services/firebase/user_firestore.dart';
import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/features/appointments/presentation/pages/pet_appointment_page.dart';
import 'package:pet_app/features/health/presentation/pages/pet_health_page.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/profile/presentation/pages/empty_profile.dart';
import 'package:pet_app/features/profile/presentation/pages/home_page_profile.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';
import 'package:pet_app/features/store/presentation/pages/pet_store_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  ProfileSetupCubit() : super(ProfileSetupInitial());

  static ProfileSetupCubit get(context) => BlocProvider.of(context);

  User? user;

  late final PageController petProfilesCarouselController =
      PageController(initialPage: user?.ownedPets.length ?? 1 - 1);

  final AdvancedDrawerController drawerScaffoldKey = AdvancedDrawerController();
  int currentBottomSheetIndex = 0;

  late final List<Widget> pages = [
    user!.ownedPets.isNotEmpty
        ? const HomePageProfile()
        : const EmptyProfileStartUp(),
    PetHealthPage(),
    PetAppointmentPage(),
    PetStorePage(),
  ];

  void getUser() async {
    emit(SavedUserFound(user: user, responseStatus: ResponseStatus.loading));
    log('Getting user from local...');
    user = await dpi<UserFirestore>().get(
      LocalSharedPreferences.read(
        Constants.localUserId,
        fallBack: '',
      ),
    );
    if (user != null) {
      emit(SavedUserFound(user: user!, responseStatus: ResponseStatus.success));
    } else {
      emit(SavedUserFound(
        user: user!,
        responseStatus: ResponseStatus.error,
        errorMessage: 'No user found',
      ));
    }
  }

  void changeBottomSheet(int index) {
    switch (index) {
      case 3:
        if (currentBottomSheetIndex == index) {
          dpi<PetStoreCubit>().add(GetProductCategoriesEvent());
        }
        break;
    }
    currentBottomSheetIndex = index;
    emit(ChangeBottomCurrentIndexState(index));
  }

  //* Contacts
  int currentContactCategorySelection = 0;
  void changeContactsView(int index) {
    currentContactCategorySelection = index;
    emit(ChangeViewState(page: currentContactCategorySelection));
  }

  //* slide to contiune button
  final GlobalKey<State<StatefulWidget>> slideToContinueKey =
      GlobalKey<State<StatefulWidget>>();
  late RenderBox renderBox =
      slideToContinueKey.currentContext!.findRenderObject() as RenderBox;
  late Offset slidePosition = renderBox.localToGlobal(Offset.zero);
  late double slideXpos = slidePosition.dx;
  late double slideYpos = slidePosition.dy;

//* pet profile sections
  final ScrollController infoListController = ScrollController();
  int currentProfileSection = 0;
  void changePetProfileView(int index) {
    currentProfileSection = index;
    emit(ChangeViewState(page: currentProfileSection));
  }

//* HEALTH
  //* insurance
  final PanelController panelInsuranceController = PanelController();
  bool isInsurancePanelOpen = false;
  void changePanel() {
    isInsurancePanelOpen = !isInsurancePanelOpen;
    debugPrint('isPanelOpened: $isInsurancePanelOpen');
    emit(ChangeColor(state: isInsurancePanelOpen));
  }

  final int insuranceMaxSteps = 3;
  int insuranceCurrentStep = 0;

  void insuranceNextStep(BuildContext context) {
    if (insuranceCurrentStep + 1 == insuranceMaxSteps) {
      insuranceCurrentStep = 0;
      Constants.replaceWithAndRemoveUntil(context, Routes.viewPetProfile);
      changePanel();
    } else {
      insuranceCurrentStep++;
    }
    emit(StepsState(step: insuranceCurrentStep));
  }

  void insurancePrevStep(BuildContext context) {
    if (insuranceCurrentStep == 0) {
      Constants.pop(context);
      changePanel();
      return;
    }
    insuranceCurrentStep--;
    emit(StepsState(step: insuranceCurrentStep));
  }

  int insurancePackage = 0;
  void changeInsurancePackage(int index) {
    insurancePackage = index;
    emit(ChangeFocusState(unit: insurancePackage));
  }

  //* vaccines
  final PanelController panelVaccineController = PanelController();

//* Nutrition
  List<bool> isSwitchedOn = List.generate(5, (index) => false);
  void toggleSwitch(int index) {
    isSwitchedOn[index] = !isSwitchedOn[index];
    emit(ToggleState(state: isSwitchedOn[index], index: index));
  }

  //* Maps
  var markers = HashSet<Marker>();

  setMapMarkers() {
    markers.add(
      const Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.21966931084816, 29.94165211934725),
      ),
    );
    emit(SetMarkersState(position: markers));
  }

  //*SETTINGS
  bool darkModeSwitch = LocalSharedPreferences.isDarkTheme();
  void darkModeSwitchAction(BuildContext context) {
    darkModeSwitch = !darkModeSwitch;
    darkModeSwitch
        ? ThemeManager.get(context).toggleTheme(ThemeEvent.darkTheme)
        : ThemeManager.get(context).toggleTheme(ThemeEvent.lightTheme);
  }

  bool locationAccessSwitch = false;
  void locationAccessSwitchAction() {
    locationAccessSwitch = !locationAccessSwitch;
    emit(ToggleState(state: locationAccessSwitch, index: 1));
  }

  bool photoAccessSwitch = false;
  void phoneAccessSwitchAction() {}
  bool appNoitfySwitch = false;
  void appNotifySwitchAction() {}
  bool emailNotifySwitch = false;
  void emailNotifySwitchAction() {}
}
