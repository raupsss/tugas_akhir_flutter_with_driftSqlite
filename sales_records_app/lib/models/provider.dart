import 'package:flutter/cupertino.dart';

class SharedProvider with ChangeNotifier {
  int totalPrice = 0;

  void changeTotalPrice(int total) {
    totalPrice = total;
    notifyListeners();
  }
}
