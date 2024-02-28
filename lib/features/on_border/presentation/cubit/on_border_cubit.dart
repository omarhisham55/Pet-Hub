import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pet_app/config/preferences/shared_preferences.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/on_border/presentation/widgets/bottomsheets.dart';
part 'on_border_state.dart';

class OnBorderCubit extends Cubit<OnBorderState> {
  OnBorderCubit() : super(OnBorderInitial());

  static OnBorderCubit get(context) => BlocProvider.of<OnBorderCubit>(context);

  final GlobalKey<FormState> createAccountFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<TextEditingController> validationCodeController =
      List.generate(5, (index) => TextEditingController());
  bool isObscured = true;
  bool checkbox = false;
  late KeyboardVisibilityController keyboardController =
      KeyboardVisibilityController();
  void initBottomsheet(context) {
    // on page initialize first panel appears
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => onBoardingBuilder(context),
      );
    });
  }

  void changeOnBorder(BuildContext context, Widget bottomsheet) async {
    await showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: double.infinity,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      useSafeArea: true,
      builder: (context) => bottomsheet,
    );
  }

  void changePassVisibility() {
    isObscured = !isObscured;
    emit(ChangePassState(value: isObscured));
  }

  void checkBox() {
    checkbox = !checkbox;
    emit(CheckboxState(value: checkbox));
  }

  void finishOnBoarding({
    required BuildContext context,
    bool? signUpLater = false,
  }) {
    LocalSharedPreferences.saveLocalPreferences(
      SharedPreferencesKeys.onBoarderComplete,
      true,
    );
    if (!signUpLater!) {
      LocalSharedPreferences.saveLocalPreferences(
        SharedPreferencesKeys.createAccountComplete,
        true,
      );
    }
    Constants.replaceWithAndRemoveUntil(context, Routes.homePageProfile);
  }
}
