import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pet_app/config/services/firebase/categories_firestore.dart';
import 'package:pet_app/config/services/firebase/firebase_service.dart';
import 'package:pet_app/config/services/firebase/user_firestore.dart';
import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/constants/internet_check.dart';
import 'package:pet_app/features/onbording/data/datasources/auth_datasource.dart';
import 'package:pet_app/features/onbording/data/repositories/auth_repo_impl.dart';
import 'package:pet_app/features/onbording/domain/repositories/auth_repo.dart';
import 'package:pet_app/features/onbording/domain/usecases/create_account_usecase.dart';
import 'package:pet_app/features/onbording/domain/usecases/login_usecase.dart';
import 'package:pet_app/features/onbording/presentation/cubit/on_bording_cubit.dart';
import 'package:pet_app/features/profile/data/datasources/pets_categories_datasource.dart';
import 'package:pet_app/features/profile/data/repositories/pets_categories_repo_impl.dart';
import 'package:pet_app/features/profile/domain/repositories/pets_categories_repo.dart';
import 'package:pet_app/features/profile/domain/usecases/get_pets_categories_usecase.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

final dpi = GetIt.instance;

final logger = Logger();

class Dpi {
  Future<void> init() async {
    await registerCore();
    registerCubits();
    registerDatasources();
    registerRepos();
    registerUsecases();
  }

  Future<void> registerCore() async {
    await LocalSharedPreferences.init();
    dpi.registerLazySingleton<FirebaseService>(() =>
        FirebaseService(client: FirebaseAuth.instance, userFirestore: dpi()));

    dpi.registerLazySingleton<UserFirestore>(
        () => UserFirestore(client: FirebaseFirestore.instance));
    dpi.registerLazySingleton<CategoryFirestore>(
        () => CategoryFirestore(client: FirebaseFirestore.instance));

    dpi.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  }

  void registerCubits() {
    dpi.registerLazySingleton(() => ThemeManager());
    dpi.registerLazySingleton(() => OnBordingCubit(dpi(), dpi()));
    dpi.registerLazySingleton(() => ProfileSetupCubit(dpi()));
  }

  void registerDatasources() {
    dpi.registerLazySingleton<AuthDatasource>(
        () => AuthDatasourceImpl(client: dpi()));
    dpi.registerLazySingleton<PetsCategoriesDatasource>(
        () => PetsCategoriesDatasourceImpl(categoryFirestore: dpi()));
  }

  void registerRepos() {
    dpi.registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl(authDatasource: dpi(), connection: dpi()));
    dpi.registerLazySingleton<PetsCategoriesRepo>(() => PetsCategoriesRepoImpl(
        petsCategoriesDatasource: dpi(), network: dpi()));
  }

  void registerUsecases() {
    dpi.registerLazySingleton(() => CreateAccountUsecase(authRepo: dpi()));
    dpi.registerLazySingleton(() => LoginUsecase(authRepo: dpi()));
    dpi.registerLazySingleton(
        () => GetPetsCategoriesUsecase(petsCategoriesRepo: dpi()));
  }
}
