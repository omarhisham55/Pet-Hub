import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/config/services/firebase/user_firestore.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';

class FirebaseService {
  final FirebaseAuth _client;
  final UserFirestore _userFirestore;
  FirebaseService({
    required FirebaseAuth client,
    required UserFirestore userFirestore,
  })  : _client = client,
        _userFirestore = userFirestore;

  Future<void> createAccountWithEmail(String email, String password) async {
    logger.i('Creating user...');
    final response = await _client.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel user = UserModel(id: response.user!.uid, email: email);
    await _userFirestore.save(user);
    logger.i('User created');
  }

  Future<User> loginWithEmail(String email, String password) async {
    logger.i('logging user...');
    final response = await _client.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = await _userFirestore.get(response.user!.uid);
    return user!;
  }
}
