part of 'on_bording_cubit.dart';

abstract class OnBordingState extends Equatable {
  const OnBordingState();

  @override
  List<Object> get props => [];
}

class OnBordingInitial extends OnBordingState {}

class ChangePassState extends OnBordingState {
  final bool value;

  const ChangePassState({required this.value});

  @override
  List<Object> get props => [value];
}

class ChangeKeyboardState extends OnBordingState {
  final bool value;

  const ChangeKeyboardState({required this.value});

  @override
  List<Object> get props => [value];
}

class CheckboxState extends OnBordingState {
  final bool value;

  const CheckboxState({required this.value});

  @override
  List<Object> get props => [value];
}

final class AuthLoading extends OnBordingState {}

final class AuthSuccess extends OnBordingState {
  final User? user;
  const AuthSuccess({this.user});
}

final class AuthError extends OnBordingState {
  final String message;
  const AuthError({required this.message});
}
