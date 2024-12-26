part of 'profile_setup_cubit.dart';

abstract class ProfileSetupState extends Equatable {
  const ProfileSetupState();

  @override
  List<Object?> get props => [];
}

class ProfileSetupInitial extends ProfileSetupState {}

class SavedUserFound extends ProfileSetupState {
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

class ChangeBottomCurrentIndexState extends ProfileSetupState {
  final int index;
  const ChangeBottomCurrentIndexState(this.index);
  @override
  List<Object> get props => [index];
}

class StepsState extends ProfileSetupState {
  final int step;

  const StepsState({required this.step});
  @override
  List<Object> get props => [step];
}

class ChangeFocusState extends ProfileSetupState {
  final int unit;

  const ChangeFocusState({required this.unit});
  @override
  List<Object?> get props => [unit];
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
