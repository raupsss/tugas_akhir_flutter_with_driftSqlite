import 'package:flutter/cupertino.dart';

class SharedProvider with ChangeNotifier {
  int totalPrice = 0;
  int totalIncome = 0;

  void changeTotalPrice(int total) {
    totalPrice = total;
    notifyListeners();
  }

  void income(int total) {
    totalIncome += total;
    notifyListeners();
  }
}
