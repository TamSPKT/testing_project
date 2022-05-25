import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int value = 1;

  void increment() {
    value += 1;
    notifyListeners();
  }

  void decrement() {
    if (value > 1) {
      value -= 1;
      notifyListeners();
    }
  }
}
