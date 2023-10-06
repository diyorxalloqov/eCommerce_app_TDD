import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_with_tdd/core/data/errors/errors.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/data/model/eCommerceModel.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/data/source/service/EcommerceService.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/domain/repository/eCommerceRepository.dart';

class ECommerceRepositoryImpl implements ECommerceRepository {
  final EcommerceNetworkService res = EcommerceNetworkService();

  @override
  Future<Either<Errors, List<Product>>> getdata() async {
    var result = await res.getDatas();
    return result.fold(
      (error) => left(error),
      (ecommerceModel) => right(ecommerceModel.products),
    );
  }
}
