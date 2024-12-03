part of 'profile_setup_cubit.dart';

abstract class ProfileSetupState extends Equatable {
  const ProfileSetupState();

  @override
  List<Object?> get props => [];
}

class ProfileSetupInitial extends ProfileSetupState {}

class LoadingPetsCategories extends ProfileSetupState {
  const LoadingPetsCategories();
}

class ErrorPetsCategories extends ProfileSetupState {
  final String error;
  const ErrorPetsCategories(this.error);
  @override
  List<Object> get props => [error];
}

class SuccessPetsCategories extends ProfileSetupState {
  final List<PetCategory> pets;
  const SuccessPetsCategories(this.pets);
  @override
  List<Object> get props => [pets];
}

class StepsState extends ProfileSetupState {
  final int step;

  const StepsState({required this.step});
  @override
  List<Object> get props => [step];
}

class NameChange extends ProfileSetupState {
  final String step;

  const NameChange({required this.step});
  @override
  List<Object> get props => [step];
}

class ChangeFocus extends ProfileSetupState {
  final String? categoryId;
  final int? index;

  const ChangeFocus({this.categoryId, this.index});
  @override
  List<Object?> get props => [categoryId, index];
}

class ChangeUnit extends ProfileSetupState {
  final String unit;

  const ChangeUnit({required this.unit});
  @override
  List<Object> get props => [unit];
}

class ChangeDate extends ProfileSetupState {
  final String date;

  const ChangeDate({required this.date});
  @override
  List<Object> get props => [date];
}

class ChangeViewState extends ProfileSetupState {
  final int page;

  const ChangeViewState({required this.page});
  @override
  List<Object> get props => [page];
}

class ChangeColor extends ProfileSetupState {
  final bool state;

  const ChangeColor({required this.state});
  @override
  List<Object> get props => [state];
}

class ToggleState extends ProfileSetupState {
  final bool state;
  final int index;

  const ToggleState({required this.state, required this.index});
  @override
  List<Object> get props => [state, index];
}

class SetMarkersState extends ProfileSetupState {
  final dynamic position;

  const SetMarkersState({required this.position});
  @override
  List<Object> get props => [position];
}
