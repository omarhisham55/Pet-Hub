import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/exceptions.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/internet_check.dart';

mixin NetworkCheckMixin {
  NetworkInfo get networkInfo;

  Future<Either<Failure, T>> checkNetworkConnection<T>(
      Future<Either<Failure, T>> Function() operation) async {
    if (await networkInfo.isConnected) {
      return await operation();
    } else {
      return const Left(NoInternetConnection());
    }
  }
}

mixin CheckForErrorsMixin {
  Future<Either<Failure, T>> checkFirestoreErrors<T>(
      Future<Either<Failure, T>> Function() operation) async {
    try {
      return await operation();
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebase(
        FirebaseExceptions.fromFirebaseException(e),
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
