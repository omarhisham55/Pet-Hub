import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/internet_check.dart';

mixin NetworkCheckMixin {
  NetworkInfo get networkInfo;

  Future<Either<Failure, T>> checkNetworkConnection<T>(
      Future<T> Function() operation) async {
    if (await networkInfo.isConnected) {
      return Right(await operation());
    } else {
      return const Left(NoInternetConnection());
    }
  }
}
