part of 'pet_profile_cubit.dart';

abstract class PetProfileState extends Equatable {
  const PetProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileSetupInitial extends PetProfileState {}

class SavedUserFound extends PetProfileState {
  final User? user;
  final String errorMessage;
  final ResponseStatus responseStatus;

  const SavedUserFound({
    required this.user,
    required this.responseStatus,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [user];
}

class DeletePetErrorState extends PetProfileState {
  final String message;
  const DeletePetErrorState(this.message);
}

class DeletePetSuccessState extends PetProfileState {}

class StepsState extends PetProfileState {
  final int step;

  const StepsState({required this.step});
  @override
  List<Object> get props => [step];
}

class ChangeFocusState extends PetProfileState {
  final int unit;

  const ChangeFocusState({required this.unit});
  @override
  List<Object?> get props => [unit];
}

class ChangeDate extends PetProfileState {
  final String date;

  const ChangeDate({required this.date});
  @override
  List<Object> get props => [date];
}

class ChangeViewState extends PetProfileState {
  final int page;

  const ChangeViewState({required this.page});
  @override
  List<Object> get props => [page];
}

class ChangeColor extends PetProfileState {
  final bool state;

  const ChangeColor({required this.state});
  @override
  List<Object> get props => [state];
}

class ToggleState extends PetProfileState {
  final bool state;
  final int index;

  const ToggleState({required this.state, required this.index});
  @override
  List<Object> get props => [state, index];
}

class SetMarkersState extends PetProfileState {
  final dynamic position;

  const SetMarkersState({required this.position});
  @override
  List<Object> get props => [position];
}
