import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/config/services/di/dpi.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/features/onbording/data/models/user_model.dart';
import 'package:pet_app/features/onbording/domain/entities/user.dart';

class UserFirestore {
  final FirebaseFirestore _client;
  UserFirestore({required FirebaseFirestore client}) : _client = client;

  Future<User?> get(String id) async {
    final response = await _client
        .collection(Constants.firestoreUserCollection)
        .doc(id)
        .get();
    logger.f('current user: ${response.data()}');
    if (response.data() != null) {
      return UserModel.fromJson(response.data()!);
    }
    return null;
  }

  Future<void> save(UserModel user) async {
    await _client
        .collection(Constants.firestoreUserCollection)
        .doc(user.id)
        .set(user.toJson());
  }

  Future<User?> update(UserModel user) async {
    await _client
        .collection(Constants.firestoreUserCollection)
        .doc(user.id)
        .update(user.toJson());
    return await get(user.id);
  }
}
