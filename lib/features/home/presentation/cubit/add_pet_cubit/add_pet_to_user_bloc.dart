import 'dart:async';
import 'dart:io';
import 'dart:math' show Random;
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/core/shared/components/dialogs/exit_dialog.dart';
import 'package:pet_app/core/shared/components/toast.dart';
import 'package:pet_app/core/shared/constants/common_functions.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/onbording/domain/usecases/update_user_usecase.dart';
import 'package:pet_app/features/home/data/models/pet_model.dart';
import 'package:pet_app/features/home/domain/entities/pet_category.dart';
import 'package:pet_app/features/home/domain/usecases/get_pets_categories_usecase.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/breed.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/category.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/important_dates.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/name.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/size.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/weight.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

part 'add_pet_to_user_events.dart';
part 'add_pet_to_user_state.dart';
part 'add_pet_to_user_steps.dart';

class AddPetBloc extends Bloc<AddPetEvents, AddPetState> {
  final GetPetsCategoriesUsecase getPetsCategoriesUsecase;
  final UpdateUserUsecase updateUserUsecase;
  AddPetBloc(
    this.getPetsCategoriesUsecase,
    this.updateUserUsecase,
  ) : super(AddPetState(progress: AddPetStep.category)) {
    on<AddPetEvents>(
      (event, emit) async => switch (event) {
        GetCategoriesEvent() => await _getPetsCategories(emit),
        ChangeStepEvent() => await _changeStep(emit, event),
        ChangeItemEvent() => _changeItem(emit, event),
        CategoryEvent() => emit(state.copyWith(
            progress: AddPetStep.breed,
            category: event.category,
          )),
        BreedEvent() => emit(state.copyWith(
            progress: AddPetStep.name,
            breed: event.breed,
          )),
        NameAndGenderEvent() => emit(state.copyWith(
            progress: AddPetStep.size,
            name: petNameController.text,
            gender: event.gender,
          )),
        ImageEvent() => await _pickImage(emit),
        SizeEvent() => {
            _changeWeightAccordingToSize(event.carouselIndex),
            emit(state.copyWith(
              progress: AddPetStep.weight,
              carouselIndex: event.carouselIndex,
            ))
          },
        WeightEvent() => emit(state.copyWith(
            progress: AddPetStep.importantDates,
            weight: weightKgAndLbs(scalePickerController.value, state.isKg),
          )),
        ImportantDatesEvent() => emit(state.copyWith(
            // progress: AddPetStep.careTakers,
            age: event.age,
            birthDate: event.birthDate,
            adoptionDate: event.adoptionDate,
            adoptionAge: event.adoptionAge,
          )),
        CareTakerEvent() => null,
        AddPetToUserEvent() => await _addPetToProfile(emit, event),
      },
    );
  }
  bool initCategories = false;
  List<PetCategory> petsCategories = [];
  XFile? imageFile;
  final TextEditingController petNameController = TextEditingController();
  RulerScalePickerController<int> scalePickerController =
      NumericRulerScalePickerController(lastValue: 120, firstValue: 0);

  Future<void> _getPetsCategories(Emitter<AddPetState> emit) async {
    if (petsCategories.isNotEmpty) {
      emit(state.copyWith(responseStatus: ResponseStatus.success));
      return;
    }
    emit(state.copyWith(responseStatus: ResponseStatus.loading));
    petsCategories = [];
    final result = await getPetsCategoriesUsecase(NoParams());
    emit(
      result.fold(
        (l) => state.copyWith(
          responseStatus: ResponseStatus.error,
          messageError: l.message,
        ),
        (r) {
          petsCategories = r;
          return state.copyWith(responseStatus: ResponseStatus.success);
        },
      ),
    );
  }

  Future<void> _pickImage(Emitter<AddPetState> emit) async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    final bytes = await File(imageFile!.path).readAsBytes();
    emit(state.copyWith(imgBytes: bytes));
  }

  Future<void> _changeStep(
      Emitter<AddPetState> emit, ChangeStepEvent event) async {
    if (event.stepNumber < 0) {
      await showExitDialog(
        context: event.context,
        title: MainStrings.addPetExitDialogTitle,
        content: MainStrings.addPetExitDialogContent,
        onAgreeClick: () {
          emit(state.clear());
          Constants.removeAllAndAddNewRoute(
              event.context, Routes.navigationManager);
          initCategories = false;
        },
      );
      return;
    }
    emit(state.copyWith(
        progress: AddPetStep.values.elementAt(event.stepNumber)));
  }

  void _changeItem(Emitter<AddPetState> emit, ChangeItemEvent event) {
    switch (state.progress) {
      case AddPetStep.category:
        emit(state.copyWith(category: event.item as String));
        break;
      case AddPetStep.breed:
        emit(state.copyWith(breed: event.item as String));
        break;
      case AddPetStep.name:
        emit(state.copyWith(gender: event.item as bool));
        break;
      case AddPetStep.size:
        _changeWeightAccordingToSize(event.item as int);
        emit(state.copyWith(
          carouselIndex: event.item as int,
          weight: scalePickerController.value.toString(),
        ));
        break;
      case AddPetStep.weight:
        emit(state.copyWith(isKg: event.item as bool));
        break;
      case AddPetStep.importantDates:
        emit(state.copyWith(
          age: event.item as String,
          birthDate: event.extraItems[0] as String,
          adoptionDate: event.extraItems[1] as String,
          adoptionAge: event.extraItems[2] as String,
        ));
        break;
      case AddPetStep.careTakers:
        // emit(state.copyWith());
        break;
    }
  }

  void _changeWeightAccordingToSize(int carouselIndex) {
    switch (carouselIndex) {
      case 0:
        scalePickerController.setValue(Random().nextInt(15));
      case 1:
        scalePickerController.setValue(Random().nextInt(25 - 14 + 1) + 14);
      case 2:
        scalePickerController.setValue(Random().nextInt(95) + 25);
    }
  }

  Timer? _debounce;
  void onContinueClickEvents(context) {
    if (_debounce?.isActive ?? false) return null;
    _debounce = Timer(const Duration(milliseconds: 300), () {
      switch (state.progress) {
        case AddPetStep.category:
          state.category.isEmpty
              ? showToast(
                  text: 'select a category',
                  state: ToastStates.warning,
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_SHORT,
                )
              : add(CategoryEvent(category: state.category));
          break;
        case AddPetStep.breed:
          state.breed.isEmpty
              ? showToast(
                  text: 'select a breed',
                  state: ToastStates.warning,
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_SHORT,
                )
              : add(BreedEvent(breed: state.breed));
          break;
        case AddPetStep.name:
          petNameController.text.isEmpty
              ? showToast(
                  text: 'select a valid name',
                  state: ToastStates.warning,
                  toastLength: Toast.LENGTH_SHORT,
                )
              : add(NameAndGenderEvent(
                  name: petNameController.text,
                  gender: state.gender,
                ));

          break;
        case AddPetStep.size:
          add(SizeEvent(carouselIndex: state.carouselIndex));
          break;
        case AddPetStep.weight:
          add(WeightEvent(
              weight: weightKgAndLbs(
            scalePickerController.value,
            state.isKg,
          )));
          break;
        case AddPetStep.importantDates:
          (state.birthDate.isEmpty || state.adoptionDate.isEmpty)
              ? showToast(
                  text: 'Required dates',
                  state: ToastStates.warning,
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_SHORT,
                )
              : {
                  add(ImportantDatesEvent(
                    age: state.age,
                    adoptionAge: state.adoptionAge,
                    birthDate: state.birthDate,
                    adoptionDate: state.adoptionDate,
                  )),
                  state.printState(),
                  Constants.navigateTo(context, Routes.addNewPetProfile,
                      arguments: {
                        'pet': PetModel(
                          id: generateId(),
                          category: state.category,
                          breed: state.breed,
                          name: state.name,
                          gender: state.gender
                              ? MainStrings.male
                              : MainStrings.female,
                          size: MainStrings.sizeInfo.keys
                              .toList()[state.carouselIndex],
                          weight: state.weight,
                          age: state.age,
                          birthDate: state.birthDate,
                          adoptionAge: state.adoptionAge,
                          adoptionDate: state.adoptionDate,
                          imgUrl: state.imgBytes,
                        )
                      }),
                };
          break;
        case AddPetStep.careTakers:
          add(CareTakerEvent(careTaker: state.careTakers));
          break;
      }
    });
  }

  Future<void> _addPetToProfile(
      Emitter<AddPetState> emit, AddPetToUserEvent event) async {
    emit(state.copyWith(responseStatus: ResponseStatus.loading));
    final user = dpi<PetProfileCubit>().user as UserModel;
    final List<PetModel> pets = List.from(user.ownedPets)..add(event.pet);
    final editedUser = UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      ownedPets: pets,
    );
    final response = await updateUserUsecase(editedUser);
    emit(response.fold(
      (l) => state.copyWith(
        responseStatus: ResponseStatus.error,
        messageError: l.message,
      ),
      (r) {
        petNameController.clear();
        emit(state.clear());
        dpi<PetProfileCubit>().getUser();
        return state.copyWith(responseStatus: ResponseStatus.success);
      },
    ));
  }

  @override
  onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(responseStatus: ResponseStatus.error));
  }
}
