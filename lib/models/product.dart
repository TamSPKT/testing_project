import 'package:testing_project/api/product.dart';

class ProductModel {
  late int id;
  late String name;
  late String category;
  late String imageLink;
  late int cost;
  late String info;

  ProductModel();

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'] ?? "";
    imageLink = json['imageLink'] ?? "";
    cost = json['cost'];
    info = json['info'] ?? "";
  }

  Future<ProductModel> getProduct(int id) async {
    return await ProductApi().getProduct(id);
  }

  Future<List<ProductModel>> getProductsList(ProductArguments args) async {
    if (args.randomCount != null) {
      return await ProductApi().getRandomProducts(args.randomCount!);
    } else if (args.name != null) {
      return await ProductApi().getProductsByName(args.name!);
    } else if (args.category != null) {
      return await ProductApi().getProductsByCategory(args.category!);
    } else if (args.ids != null) {
      return await ProductApi().getProductsById(args.ids!);
    }
    return await ProductApi().getProducts();
  }
}

class Product {
  int price; // price
  String productName; // name of the product
  int rating; // rating
  String imgUrl; // product image url
  int noOfRating; // number of rating

  Product({required this.productName,
    required this.imgUrl,
    required this.price,
    required this.rating,
    required this.noOfRating});
}

class ProductArguments {
  final int? randomCount;
  final String? category;
  final String? name;
  final List<int>? ids;

  ProductArguments({this.randomCount, this.category, this.name, this.ids});
}
