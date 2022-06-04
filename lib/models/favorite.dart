import 'package:flutter/material.dart';
import 'package:testing_project/models/product.dart';

class FavoriteModel extends ChangeNotifier {
  final List<int> _productIds = [0];

  List<int> get productIds => _productIds;

  Future<List<ProductModel>> getProductsList() async {
    return await ProductModel()
        .getProductsList(ProductArguments(ids: _productIds));
  }

  bool contains(int productId) => _productIds.contains(productId);

  void add(int productId) {
    _productIds.add(productId);
    notifyListeners(); // Tell dependent widgets to rebuild the widgets that depend on CartModel
  }

  void remove(int productId) {
    _productIds.remove(productId);
    notifyListeners(); // Tell dependent widgets to rebuild the widgets that depend on CartModel
  }
}
