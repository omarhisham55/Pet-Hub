import 'package:pet_app/config/services/firebase/firebase_service.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<void> createAccountWithEmail(String email, String password);
  Future<User> loginWithEmail(String email, String password);
}

class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseService client;

  AuthDatasourceImpl({required this.client});
  @override
  Future<void> createAccountWithEmail(String email, String password) async =>
      await client.createAccountWithEmail(email, password);

  @override
  Future<User> loginWithEmail(String email, String password) async =>
      await client.loginWithEmail(email, password);
}
