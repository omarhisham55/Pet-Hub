import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/config/services/firebase/user_firestore.dart';
import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/profile/domain/entities/pet_category.dart';
import 'package:pet_app/features/profile/domain/usecases/get_pets_categories_usecase.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  final GetPetsCategoriesUsecase getPetsCategoriesUsecase;
  ProfileSetupCubit(this.getPetsCategoriesUsecase)
      : super(ProfileSetupInitial());

  static ProfileSetupCubit get(context) => BlocProvider.of(context);

  List<PetCategory> petsCategories = [];
  int numberOfPets = LocalSharedPreferences.numberOfPets();
  PageController pageController = PageController();
  AdvancedDrawerController drawerScaffoldKey = AdvancedDrawerController();
  User? user;

  void getUser() async {
    user = await dpi<UserFirestore>().get(
      LocalSharedPreferences.read(
        Constants.localUserId,
        fallBack: '',
      ),
    );
  }

  void getPetsCategories() async {
    emit(LoadingPetsCategories());
    petsCategories = [];
    final result = await getPetsCategoriesUsecase(NoParams());
    emit(
      result.fold(
        (l) => ErrorPetsCategories(l.message),
        (r) {
          petsCategories = r;
          logger.d('${r.length} ${r.map((p) => p.breeds.length).toList()}');
          return SuccessPetsCategories(r);
        },
      ),
    );
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

  final int setupPetProfileMaxSteps = 6;
  int setupPetProfileCurrentStep = 0;

  void addNewPetProfile(BuildContext context) {
    LocalSharedPreferences.write(
      Constants.localNumberOfPets,
      ++numberOfPets,
    );
    drawerScaffoldKey.hideDrawer();
    setupPetProfileCurrentStep = 0;
    Constants.replaceWithAndRemoveUntil(context, Routes.homePageProfile);
    emit(StepsState(step: numberOfPets));
  }

  //* first entry steps
  void petProfileNextStep(BuildContext context) {
    if (setupPetProfileCurrentStep + 1 == setupPetProfileMaxSteps) {
      Constants.navigateTo(context, Routes.addNewPetProfile);
    } else {
      setupPetProfileCurrentStep++;
    }
    emit(StepsState(step: setupPetProfileCurrentStep));
  }

  void petProfilePrevStep(BuildContext context) {
    if (setupPetProfileCurrentStep == 0) {
      Constants.pop(context);
      return;
    }
    setupPetProfileCurrentStep--;
    emit(StepsState(step: setupPetProfileCurrentStep));
  }

  //* change category
  String? category;
  String? breed;
  void changeCategory(String category) {
    this.category = category;
    emit(ChangeFocus(categoryId: this.category));
  }

  void changeBreed(String category) {
    breed = category;
    emit(ChangeFocus(categoryId: breed));
  }

  //* petName page
  final TextEditingController petNameController = TextEditingController();
  void nameChange() {
    emit(NameChange(step: petNameController.text));
  }

  //* petSize page
  int carouselIndex = 0;
  void changeFocus(int index) {
    carouselIndex = index;
    emit(ChangeFocus(index: index));
  }

  //* weight page
  RulerScalePickerController<int> scalePickerController =
      NumericRulerScalePickerController(
    lastValue: 120,
    firstValue: 0,
  );
  String selectedUnit = 'kg';
  void changeUnit(value) {
    selectedUnit = value;
    emit(ChangeUnit(unit: selectedUnit));
  }

  String birthDate = '';
  String petAge = '';
  String petAdoptionAge = '';
  String adoptionDate = '';
  void openBirthCalendar(BuildContext context) async {
    late DateTime? date;
    date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      if (date.year != DateTime.now().year) {
        petAge = "${(DateTime.now().year - date.year).toString()} y.o";
      } else if (date.month != DateTime.now().month) {
        petAge = "${(DateTime.now().month - date.month).toString()} months";
      } else {
        petAge = "${(DateTime.now().day - date.day).toString()} days";
      }
    }
    birthDate = DateFormat('d MMM yyyy').format(
      date ?? DateTime.now(),
    );
    emit(ChangeDate(date: birthDate.codeUnits.toString()));
  }

  void openAdoptionCalendar(BuildContext context) async {
    late DateTime? date;
    date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      if (date.year != DateTime.now().year) {
        petAdoptionAge =
            "${(DateTime.now().year - date.year).toString()} years ago";
      } else if (date.month != DateTime.now().month) {
        petAdoptionAge =
            "${(DateTime.now().month - date.month).toString()} months ago";
      } else {
        petAdoptionAge =
            "${(DateTime.now().day - date.day).toString()} days ago";
      }
    }
    adoptionDate = DateFormat('d MMM yyyy').format(
      date ?? DateTime.now(),
    );
    emit(ChangeDate(date: adoptionDate.hashCode.toString()));
  }

//* pet profile sections
  final ScrollController infoListController = ScrollController();
  int currentProfileSection = 0;
  void changePetProfileView(int index) {
    currentProfileSection = index;
    emit(ChangeViewState(page: currentProfileSection));
  }

  //* add pet profile continue button
  void petProfileContinueButton(BuildContext context) {
    switch (setupPetProfileCurrentStep) {
      case 0:
        category != null ? petProfileNextStep(context) : null;
        break;
      case 1:
        breed != null ? petProfileNextStep(context) : null;
        break;
      case 2:
        petNameController.text.isEmpty ? null : petProfileNextStep(context);
        break;
      case 3:
      // break;
      case 4:
      // break;
      case 5:
        petProfileNextStep(context);
        break;
    }
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
    emit(ChangeFocus(index: insurancePackage));
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
