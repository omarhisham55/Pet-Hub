import 'package:flutter/material.dart';
import 'package:pet_app/core/error/page_not_found.dart';
import 'package:pet_app/features/onbording/presentation/pages/on_bording_screen.dart';
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

class Routes {
  static const String splashScreen = '/';
  static const String onBording = '/onBorder';
  static const String homePageProfile = '/homePageProfile';
  static const String addPetProfile = '/AddPetProfile';
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

  Map<String, Route<dynamic> Function(RouteSettings settings)> get routes {
    return {
      splashScreen: (settings) => MaterialPageRoute(
            builder: (context) => const SplashScreen(),
            settings: settings,
          ),
      onBording: (settings) => MaterialPageRoute(
            builder: (context) => const OnBordingScreen(),
            settings: settings,
          ),
      homePageProfile: (settings) => MaterialPageRoute(
            builder: (context) => const HomePageManager(),
            settings: settings,
          ),
      addPetProfile: (settings) => MaterialPageRoute(
            builder: (context) => const AddPetProfile(),
            settings: settings,
          ),
      shareProfile: (settings) => MaterialPageRoute(
            builder: (context) => const ShareProfile(),
            settings: settings,
          ),
      qrCodeScan: (settings) => MaterialPageRoute(
            builder: (context) => const QRCodeScan(),
            settings: settings,
          ),
      addNewPetProfile: (settings) => MaterialPageRoute(
            builder: (context) => const AddNewPetProfile(),
            settings: settings,
          ),
      viewPetProfile: (settings) => MaterialPageRoute(
            builder: (context) => const ViewPetProfile(),
            settings: settings,
          ),
      petProfileHealthDetails: (settings) => MaterialPageRoute(
            builder: (context) => PetProfileHealthDetails(
              subTitle: settings.arguments as String,
            ),
            settings: settings,
          ),
      recipes: (settings) => MaterialPageRoute(
            builder: (context) => const Recipes(),
            settings: settings,
          ),
      contacts: (settings) => MaterialPageRoute(
            builder: (context) => const Contacts(),
            settings: settings,
          ),
      contactsDetails: (settings) => MaterialPageRoute(
            builder: (context) => const ContactDetails(),
            settings: settings,
          ),
      bookADate: (settings) => MaterialPageRoute(
            builder: (context) => const BookADate(),
            settings: settings,
          ),
      calendar: (settings) => MaterialPageRoute(
            builder: (context) => const Calendar(),
            settings: settings,
          ),
      settings: (settings) => MaterialPageRoute(
            builder: (context) => const Settings(),
            settings: settings,
          ),
      intoActivities: (settings) => MaterialPageRoute(
            builder: (context) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as ProfileActivityArguments;
              return ProfileActivityManager(
                subTitle: args.subTitle,
                body: args.body,
              );
            },
            settings: settings,
          ),
      maps: (settings) => MaterialPageRoute(
            builder: (context) {
              final args =
                  ModalRoute.of(context)!.settings.arguments as MapArguments;
              return OpenMaps(
                title: args.title,
                subTitle: args.subTitle,
              );
            },
            settings: settings,
          ),
    };
  }

  Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const PageNotFound(),
    );
  }
}

class OnGenerateRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = Routes().routes[settings.name];
    if (route != null) {
      return route(settings);
    }
    return Routes().undefinedRoute();
  }
}
