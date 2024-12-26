import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/config/responsive/responsive_manager.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/constants/bloc_observer.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/core/shared/constants/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await ResponsiveManager.desktopConstraints();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Dpi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      builder: (context) => BlocProvider(
        create: (context) => dpi<ThemeManager>(),
        child: BlocBuilder<ThemeManager, ThemeState>(
          builder: (context, state) {
            ThemeManager.currentTheme = state;
            return MaterialApp.router(
              title: MainStrings.title,
              theme: state.themeData,
              routerConfig: Routes.router,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
