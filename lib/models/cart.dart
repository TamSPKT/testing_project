import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalCost => _items.fold(
      0, (total, current) => total + (current.cost! * current.quantity));

  bool contains(int productId) => _items.contains(CartItem(id: productId));

  void add({required CartItem item, required int amount}) {
    if (_items.contains(item)) {
      int idx = _items.indexOf(item);
      _items[idx].increment(amount);
    } else {
      item.increment(amount);
      _items.add(item);
    }
    notifyListeners();
  }

  void remove({required CartItem item, required int amount}) {
    if (_items.contains(item)) {
      int idx = _items.indexOf(item);
      _items[idx].decrement(amount);
      if (_items[idx].quantity == 0) {
        _items.remove(item);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class CartItem {
  final int id;
  final String? name;
  final int? cost;
  final String? imageSrc;
  int quantity = 0;

  CartItem({required this.id, this.name, this.cost, this.imageSrc});

  void increment(int amount) {
    quantity += amount;
  }

  void decrement(int amount) {
    if ((quantity - amount) > 0) {
      quantity -= amount;
    } else {
      quantity = 0;
    }
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is CartItem && other.id == id;
}
