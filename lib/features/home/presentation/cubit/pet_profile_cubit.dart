import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/config/services/firebase/user_firestore.dart';
import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/onbording/domain/usecases/update_user_usecase.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'pet_profile_state.dart';

class PetProfileCubit extends Cubit<PetProfileState> {
  final UpdateUserUsecase updateUserUsecase;
  PetProfileCubit(
    this.updateUserUsecase,
  ) : super(ProfileSetupInitial());

  static PetProfileCubit get(context) => BlocProvider.of(context);

  User? user;

  late final PageController petProfilesCarouselController =
      PageController(initialPage: user?.ownedPets.length ?? 1 - 1);

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
      emit(SavedUserFound(user: user, responseStatus: ResponseStatus.success));
      log('user from local: ${user?.name.toString()}');
    } else {
      emit(SavedUserFound(
        user: user,
        responseStatus: ResponseStatus.error,
        errorMessage: 'No user found',
      ));
    }
  }

  Future<void> deletePetFromUser(String petId) async {
    if (user == null) return;
    final editedUser = UserModel(
      id: user!.id,
      email: user!.email,
      name: user!.name,
      ownedPets: user!.ownedPets..removeWhere((pet) => pet.id == petId),
    );
    final response = await updateUserUsecase(editedUser);
    emit(response.fold(
      (l) => DeletePetErrorState(l.message),
      (r) {
        dpi<PetProfileCubit>().getUser();
        return DeletePetSuccessState();
      },
    ));
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
      Constants.removeAllAndAddNewRoute(context, Routes.viewPetProfile);
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
}
