part of 'navigation_cubit.dart';

sealed class NavigationCubitState {
  final int index;
  const NavigationCubitState(this.index);
}

final class NavigationCubitInitial extends NavigationCubitState {
  NavigationCubitInitial() : super(0);
}

class NavbarChangeState extends NavigationCubitState {
  final int index;
  NavbarChangeState(this.index) : super(0);
}
