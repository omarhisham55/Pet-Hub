import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/preferences/shared_preferences.dart';
import 'package:pet_app/config/responsive/responsive_manager.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/bloc_observer.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/on_border/presentation/cubit/on_border_cubit.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await ResponsiveManager.desktopConstraints();
  await LocalSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeManager()),
        BlocProvider(create: (context) => OnBorderCubit()),
        BlocProvider(create: (context) => ProfileSetupCubit()),
      ],
      child: BlocBuilder<ThemeManager, ThemeState>(
        builder: (context, state) {
          ThemeManager.currentTheme = state;
          return MaterialApp(
            title: MainStrings.title,
            theme: state.themeData,
            onGenerateRoute: (settings) =>
                OnGenerateRoute.onGenerateRoute(settings),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
