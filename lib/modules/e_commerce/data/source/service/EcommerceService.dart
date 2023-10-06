import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_with_tdd/core/data/errors/errors.dart';
import 'package:ecommerce_app_with_tdd/core/singletons/dio.dart';
import 'package:ecommerce_app_with_tdd/core/singletons/serviceInit.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/data/model/eCommerceModel.dart';

class EcommerceNetworkService {
  final Dio dio = serviceLocator<DioSettings>().dio;

  Future<Either<Errors, EcommerceModel>> getDatas() async {
    try {
      Response response = await dio.get('http://192.168.42.184:8080/products');
      if (response.statusCode == 200) {
        print(response.data);
        return right(EcommerceModel.fromJson(response.data));
      } else {
        print("xato");
        return left(ServerErrors(message: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      print(e.message.toString());
      return left(ServerErrors(message: e.error.toString()));
    }
  }
}
