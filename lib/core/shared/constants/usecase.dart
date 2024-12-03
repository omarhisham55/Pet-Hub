import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_app/core/error/failure.dart';

abstract class UseCase<T, Parameter> {
  Future<Either<Failure, T>> call(Parameter parameter);
}

abstract class NoParamsUsecase<T> extends UseCase<T, NoParams> {}

abstract class OneParamUsecase<T, parameter> extends UseCase<T, parameter> {}

abstract class MultiParamUsecase<T, List> extends UseCase<T, List> {}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}
