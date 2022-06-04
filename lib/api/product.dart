import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testing_project/constants.dart';
import 'package:testing_project/models/product.dart';

class ProductApi {
  // final dio = Dio();
  static const String webApiPath = ProjectConstants.webApiPath;

  Future<http.Response> _getRequest(String path) async {
    // final response = await dio.get(path);
    final response = await http.get(Uri.parse(path), headers: {
      "Access-Control-Allow-Origin": "*",
    });
    // print(response.body);
    return response;
  }

  Future<ProductModel> getProduct(int id) async {
    final response = await _getRequest("$webApiPath/api/Product/$id");
    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await _getRequest("$webApiPath/api/Product");
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(response.body);
      return List<ProductModel>.from(
          iterable.map((json) => ProductModel.fromJson(json)));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<List<ProductModel>> getProductsById(List<int> ids) async {
    String queryIds = "";
    for (var id in ids) {
      queryIds += "ids=$id&";
    }
    final response = await _getRequest("$webApiPath/api/Product?$queryIds");
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(response.body);
      return List<ProductModel>.from(
          iterable.map((json) => ProductModel.fromJson(json)));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<List<ProductModel>> getRandomProducts(int count) async {
    final response = await _getRequest("$webApiPath/api/Product/Random/$count");
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(response.body);
      return List<ProductModel>.from(
          iterable.map((json) => ProductModel.fromJson(json)));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final response =
        await _getRequest("$webApiPath/api/Product/Category/$category");
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(response.body);
      return List<ProductModel>.from(
          iterable.map((json) => ProductModel.fromJson(json)));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<List<ProductModel>> getProductsByName(String name) async {
    final response =
        await _getRequest("$webApiPath/api/Product/Find?name=$name");
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(response.body);
      return List<ProductModel>.from(
          iterable.map((json) => ProductModel.fromJson(json)));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }
}
