import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testing_project/constants.dart';
import 'package:testing_project/models/order.dart';

class OrderApi {
  static const String webApiPath = ProjectConstants.webApiPath;

  Future<http.Response> _postRequest(
      String path, Map<String, dynamic> data) async {
    final String encodedData = json.encode(data);
    final response = await http.post(
      Uri.parse(path),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
      body: encodedData,
    );
    return response;
  }

  Future<http.Response> _getRequest(String path) async {
    final response = await http.get(Uri.parse(path), headers: {
      "Access-Control-Allow-Origin": "*",
    });
    return response;
  }

  Future<List<OrderModel>> getOrders({required String userName}) async {
    final response =
        await _getRequest("$webApiPath/api/Order?userName=$userName");
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(response.body);
      return List<OrderModel>.from(
          iterable.map((json) => OrderModel.fromJson(json)));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<OrderModel> getOrder(int id) async {
    final response = await _getRequest("$webApiPath/api/Order/$id");
    if (response.statusCode == 200) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<OrderModel> postOrder(CreateOrder createOrder) async {
    Map<String, dynamic> data = {
      "userName": createOrder.userName,
      "userEmail": createOrder.userEmail,
      "userPhoneNumber": createOrder.userPhoneNumber,
      "userAddress": createOrder.userAddress,
      "productIds": createOrder.productIds,
      "productQuantities": createOrder.productQuantities,
      "totalCost": createOrder.totalCost,
    };
    final response = await _postRequest("$webApiPath/api/Order", data);
    if (response.statusCode == 200) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }
}
