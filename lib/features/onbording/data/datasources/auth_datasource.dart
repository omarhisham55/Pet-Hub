import 'package:pet_app/config/services/firebase/firebase_service.dart';
import 'package:pet_app/config/services/firebase/user_firestore.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<void> createAccountWithEmail(String email, String password);
  Future<User> loginWithEmail(String email, String password);
  Future<User?> updateUser(UserModel user);
}

class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseService client;
  final UserFirestore userFirestore;

  AuthDatasourceImpl({required this.client, required this.userFirestore});
  @override
  Future<void> createAccountWithEmail(String email, String password) async =>
      await client.createAccountWithEmail(email, password);

  @override
  Future<User> loginWithEmail(String email, String password) async =>
      await client.loginWithEmail(email, password);

  @override
  Future<User?> updateUser(UserModel user) async =>
      await userFirestore.update(user);
}
