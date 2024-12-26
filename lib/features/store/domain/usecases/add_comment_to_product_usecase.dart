import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/store/domain/repositories/product_repo.dart';

class AddCommentToProductUsecase extends MultiParamUsecase<String, List> {
  final ProductsRepo productsRepo;

  AddCommentToProductUsecase({required this.productsRepo});
  @override
  Future<Either<Failure, String>> call(parameter) async =>
      await productsRepo.addComment(parameter[0], parameter[1]);
}
