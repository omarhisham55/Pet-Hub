part of 'on_border_cubit.dart';

abstract class OnBorderState extends Equatable {
  const OnBorderState();

  @override
  List<Object> get props => [];
}

class OnBorderInitial extends OnBorderState {}

class ChangePassState extends OnBorderState {
  final bool value;

  const ChangePassState({required this.value});

  @override
  List<Object> get props => [value];
}

class ChangeKeyboardState extends OnBorderState {
  final bool value;

  const ChangeKeyboardState({required this.value});

  @override
  List<Object> get props => [value];
}

class CheckboxState extends OnBorderState {
  final bool value;

  const CheckboxState({required this.value});

  @override
  List<Object> get props => [value];
}
