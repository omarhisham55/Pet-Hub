import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pet_app/config/services/firebase/categories_firestore.dart';
import 'package:pet_app/config/services/firebase/firebase_service.dart';
import 'package:pet_app/config/services/firebase/product_firestore.dart';
import 'package:pet_app/config/services/firebase/user_firestore.dart';
import 'package:pet_app/config/services/preferences/shared_preferences.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/constants/internet_check.dart';
import 'package:pet_app/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:pet_app/features/health/presentation/cubit/health_cubit.dart';
import 'package:pet_app/features/home/presentation/cubit/navigation_cubit/navigation_cubit.dart';
import 'package:pet_app/features/onbording/data/datasources/auth_datasource.dart';
import 'package:pet_app/features/onbording/data/repositories/auth_repo_impl.dart';
import 'package:pet_app/features/onbording/domain/repositories/auth_repo.dart';
import 'package:pet_app/features/onbording/domain/usecases/create_account_usecase.dart';
import 'package:pet_app/features/onbording/domain/usecases/login_usecase.dart';
import 'package:pet_app/features/onbording/domain/usecases/update_user_usecase.dart';
import 'package:pet_app/features/onbording/presentation/cubit/on_bording_cubit.dart';
import 'package:pet_app/features/home/data/datasources/pets_categories_datasource.dart';
import 'package:pet_app/features/home/data/repositories/pets_categories_repo_impl.dart';
import 'package:pet_app/features/home/domain/repositories/pets_categories_repo.dart';
import 'package:pet_app/features/home/domain/usecases/get_pets_categories_usecase.dart';
import 'package:pet_app/features/home/presentation/cubit/add_pet_cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';
import 'package:pet_app/features/store/data/datasources/products_datasource.dart';
import 'package:pet_app/features/store/data/repositories/product_repo_impl.dart';
import 'package:pet_app/features/store/domain/repositories/product_repo.dart';
import 'package:pet_app/features/store/domain/usecases/add_comment_to_product_usecase.dart';
import 'package:pet_app/features/store/domain/usecases/add_product_usecase.dart';
import 'package:pet_app/features/store/domain/usecases/get_product_categories_usecase.dart';
import 'package:pet_app/features/store/domain/usecases/get_products_usecase.dart';
import 'package:pet_app/features/store/presentation/cubit/pet_store_cubit.dart';

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
    dpi.registerLazySingleton<ProductFirestore>(
        () => ProductFirestore(client: FirebaseFirestore.instance));

    dpi.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  }

  void registerCubits() {
    dpi.registerLazySingleton(() => ThemeManager());
    dpi.registerLazySingleton(() => NavigationCubit());
    dpi.registerLazySingleton(() => OnBordingCubit(dpi(), dpi()));
    dpi.registerLazySingleton(() => AddPetBloc(dpi(), dpi()));
    dpi.registerLazySingleton(() => PetProfileCubit(dpi()));
    dpi.registerLazySingleton(() => HealthCubit());
    dpi.registerLazySingleton(() => AppointmentsCubit());
    dpi.registerLazySingleton(() => PetStoreCubit(dpi(), dpi(), dpi(), dpi()));
  }

  void registerDatasources() {
    dpi.registerLazySingleton<AuthDatasource>(
        () => AuthDatasourceImpl(client: dpi(), userFirestore: dpi()));
    dpi.registerLazySingleton<PetsCategoriesDatasource>(
        () => PetsCategoriesDatasourceImpl(categoryFirestore: dpi()));
    dpi.registerLazySingleton<ProductsDatasource>(() => ProductsDatasourceImpl(
        categoryFirestore: dpi(), productFirestore: dpi()));
  }

  void registerRepos() {
    dpi.registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl(authDatasource: dpi(), connection: dpi()));
    dpi.registerLazySingleton<PetsCategoriesRepo>(() => PetsCategoriesRepoImpl(
        petsCategoriesDatasource: dpi(), network: dpi()));
    dpi.registerLazySingleton<ProductsRepo>(
        () => ProductsRepoImpl(productsDatasource: dpi(), network: dpi()));
  }

  void registerUsecases() {
    dpi.registerLazySingleton(() => CreateAccountUsecase(authRepo: dpi()));
    dpi.registerLazySingleton(() => LoginUsecase(authRepo: dpi()));
    dpi.registerLazySingleton(() => UpdateUserUsecase(authRepo: dpi()));
    dpi.registerLazySingleton(
        () => GetPetsCategoriesUsecase(petsCategoriesRepo: dpi()));
    dpi.registerLazySingleton(
        () => GetProductCategoriesUsecase(productsRepo: dpi()));
    dpi.registerLazySingleton(() => GetProductsUsecase(productsRepo: dpi()));
    dpi.registerLazySingleton(() => AddProductUsecase(productsRepo: dpi()));
    dpi.registerLazySingleton(
        () => AddCommentToProductUsecase(productsRepo: dpi()));
  }
}
