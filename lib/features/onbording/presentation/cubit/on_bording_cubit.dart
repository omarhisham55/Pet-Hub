import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';
import 'package:pet_app/features/onbording/domain/usecases/create_account_usecase.dart';
import 'package:pet_app/features/onbording/domain/usecases/login_usecase.dart';
import 'package:pet_app/features/onbording/presentation/widgets/bottomsheets.dart';
part 'on_bording_state.dart';

class OnBordingCubit extends Cubit<OnBordingState> {
  final CreateAccountUsecase createAccountUsecase;
  final LoginUsecase loginUsecase;
  OnBordingCubit(this.createAccountUsecase, this.loginUsecase)
      : super(OnBordingInitial());

  static OnBordingCubit get(context) =>
      BlocProvider.of<OnBordingCubit>(context);

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

  static AnimationController? _controller;
  static bool _showWidget1 = true;

  void toggleWidget() {
    _showWidget1 = !_showWidget1;
    if (_showWidget1) {
      _controller?.reverse();
    } else {
      _controller?.forward();
    }
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

  void finishOnBoarding(BuildContext context, String userId) {
    LocalSharedPreferences.write(Constants.localIsOnBoardingComplete, true);
    LocalSharedPreferences.write(Constants.localIsCreateAccountComplete, true);
    LocalSharedPreferences.write(Constants.localUserId, userId);
    Constants.replaceWithAndRemoveUntil(context, Routes.navigationManager);
  }

  void createAccount() async {
    if (createAccountFormKey.currentState!.validate()) {
      if (checkbox) {
        emit(AuthLoading());
        final result = await createAccountUsecase([
          emailController.text,
          passwordController.text,
        ]);
        result.fold((l) {
          logger.e(l.message);
          emit(AuthError(message: l.message));
        }, (r) {
          emit(AuthSuccess());
        });
      } else {
        emit(AuthError(message: 'unmarked checkbox'));
      }
    }
  }

  void login() async {
    if (createAccountFormKey.currentState!.validate()) {
      emit(AuthLoading());
      final result = await loginUsecase([
        emailController.text,
        passwordController.text,
      ]);
      result.fold((l) {
        logger.e(l.message);
        emit(AuthError(message: l.message));
      }, (r) {
        emit(AuthSuccess(user: r));
      });
    }
  }
}
