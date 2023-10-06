import 'package:ecommerce_app_with_tdd/modules/e_commerce/domain/entity/eCommerceEntity.dart';

class EcommerceModel {
  final List<Product> products;

  const EcommerceModel({required this.products});

  factory EcommerceModel.fromJson(Map<String, dynamic> json) {
    /// agar map kelsa shunaqa boladi
    /// if data is coming map showing this
    List<Product> list = (json['products'] as List<dynamic>).map((e) {
      return Product.fromJson(e);
    }).toList();

    return EcommerceModel(products: list);

    //// agar list kelsa json ozi yoziladi
    /// if data is coming list writing this
  }
}

class Product extends EcommerceEntity {
  final String image;
  final String title;
  final String description;
  final String currencySymbol;
  final int price;
  final int rating;

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.currencySymbol,
    required this.price,
    required this.rating,
  }) : super(
          image: image,
          title: title,
          description: description,
          currencySymbol: currencySymbol,
          price: price,
          rating: rating,
        );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['image'],
      title: json['title'],
      description: json['desc'],
      currencySymbol: json['currency_symbol'],
      price: json['price'],
      rating: json['rating'],
    );
  }
}
