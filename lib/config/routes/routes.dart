import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/core/error/page_not_found.dart';
import 'package:pet_app/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:pet_app/features/health/presentation/cubit/health_cubit.dart';
import 'package:pet_app/features/onbording/presentation/cubit/on_bording_cubit.dart';
import 'package:pet_app/features/onbording/presentation/pages/on_bording_screen.dart';
import 'package:pet_app/features/profile/domain/entities/pet.dart';
import 'package:pet_app/features/profile/presentation/cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/pages/add_pet_profile_steps/add_pet_profile.dart';
import 'package:pet_app/features/profile/presentation/pages/drawer_pages/calendar.dart';
import 'package:pet_app/features/profile/presentation/pages/drawer_pages/contacts/book_a_date.dart';
import 'package:pet_app/features/profile/presentation/pages/drawer_pages/contacts/contact_details.dart';
import 'package:pet_app/features/profile/presentation/pages/drawer_pages/contacts/contacts.dart';
import 'package:pet_app/features/profile/presentation/pages/drawer_pages/settings.dart';
import 'package:pet_app/features/profile/presentation/pages/home_page_manager.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/activities/activity_items/open_maps.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/activities/activity_items/profile_activity_manager.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/add_profile.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/health/into_health.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/nutrition/recipes.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/pet_profile/view_profile.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/share_profile/qr_code.dart';
import 'package:pet_app/features/profile/presentation/pages/manager_profile/share_profile/share_profile.dart';
import 'package:pet_app/features/splash_screen/splash_screen.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';
import 'package:pet_app/features/store/presentation/pages/product_details_page.dart';

class Routes {
  static const String splashScreen = '/';
  static const String onBording = '/OnBorder';
  static const String addPetProfile = '/AddPetProfile';
  static const String homePageProfile = '/HomePageProfile';
  static const String productDetailsPage = '/ProductDetailsPage';
  static const String shareProfile = '/ShareProfile';
  static const String qrCodeScan = '/qrCodeScan';
  static const String addNewPetProfile = '/addNewPetProfile';
  static const String viewPetProfile = '/viewPetProfile';
  static const String petProfileHealthDetails = '/petProfileHealthDetails';
  static const String recipes = '/recipes';
  static const String intoActivities = '/intoActivities';
  static const String maps = '/maps';
  static const String contacts = '/contacts';
  static const String contactsDetails = '/contactsDetails';
  static const String bookADate = '/bookADate';
  static const String calendar = '/calendar';
  static const String settings = '/settings';

  Routes._();

  factory Routes() => Routes._();

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onBording,
        builder: (context, state) => BlocProvider(
          create: (context) => dpi<OnBordingCubit>(),
          child: const OnBordingScreen(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => dpi<ProfileSetupCubit>()..getUser(),
            ),
            BlocProvider(create: (context) => dpi<HealthCubit>()),
            BlocProvider(create: (context) => dpi<AppointmentsCubit>()),
            BlocProvider(
              create: (context) =>
                  dpi<PetStoreCubit>()..add(GetProductCategoriesEvent()),
            ),
          ],
          child: child,
        ),
        routes: [
          GoRoute(
            path: homePageProfile,
            builder: (context, state) => const HomePageManager(),
          ),
          GoRoute(
            path: productDetailsPage,
            builder: (context, state) {
              final args = state.extra as Map<String, dynamic>;
              return ProductDetailsPage(product: args['product']);
            },
          ),
        ],
      ),
      GoRoute(
        path: addPetProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => dpi<AddPetBloc>(),
          child: const AddPetProfile(),
        ),
      ),
      GoRoute(
        path: addNewPetProfile,
        builder: (context, state) => const AddNewPetProfile(),
      ),
      GoRoute(
        path: shareProfile,
        builder: (context, state) => const ShareProfile(),
      ),
      GoRoute(
        path: qrCodeScan,
        builder: (context, state) => const QRCodeScan(),
      ),
      GoRoute(
        path: viewPetProfile,
        builder: (context, state) => ViewPetProfile(pet: state.extra as Pet),
      ),
      GoRoute(
        path: petProfileHealthDetails,
        builder: (context, state) =>
            PetProfileHealthDetails(subTitle: state.extra as String),
      ),
      GoRoute(
        path: recipes,
        builder: (context, state) => const Recipes(),
      ),
      GoRoute(
        path: contacts,
        builder: (context, state) => const Contacts(),
      ),
      GoRoute(
        path: contactsDetails,
        builder: (context, state) => const ContactDetails(),
      ),
      GoRoute(
        path: bookADate,
        builder: (context, state) => const BookADate(),
      ),
      GoRoute(
        path: calendar,
        builder: (context, state) => const Calendar(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        path: intoActivities,
        builder: (context, state) {
          final args = ModalRoute.of(context)?.settings.arguments
              as ProfileActivityArguments;
          return ProfileActivityManager(
            subTitle: args.subTitle,
            body: args.body,
          );
        },
      ),
      GoRoute(
        path: maps,
        builder: (context, state) {
          final args =
              ModalRoute.of(context)?.settings.arguments as MapArguments;
          return OpenMaps(title: args.title, subTitle: args.subTitle);
        },
      ),
    ],
    errorBuilder: (context, state) => const PageNotFound(),
  );
}
