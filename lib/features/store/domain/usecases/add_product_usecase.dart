import 'package:dartz/dartz.dart';
import 'package:pet_app/core/error/failure.dart';
import 'package:pet_app/core/shared/constants/usecase.dart';
import 'package:pet_app/features/store/data/models/product_model.dart';
import 'package:pet_app/features/store/domain/repositories/product_repo.dart';

class AddProductUsecase extends UseCase<bool, ProductModel> {
  final ProductsRepo productsRepo;

  AddProductUsecase({required this.productsRepo});
  @override
  Future<Either<Failure, bool>> call(ProductModel parameter) async =>
      await productsRepo.addProduct(parameter);
}
