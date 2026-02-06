import 'package:flutter/material.dart';
import 'package:isystem/core/core.dart';

import '../database/db_helper.dart';

class SalesProvider extends ChangeNotifier {
  Future<void> saveSale(ProductModel product, String paymentMethod) async {
    final newSale = {
      'productName': product.name,
      'amount': product.price,
      'date': DateTime.now().toIso8601String(),
      'isSynced': 0,
      'paymentMethod': paymentMethod,
    };

    await DatabaseHelper.instance.insertSale(newSale);
    notifyListeners();
  }
}
