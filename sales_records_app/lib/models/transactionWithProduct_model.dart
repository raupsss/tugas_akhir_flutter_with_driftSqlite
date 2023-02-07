// ignore_for_file: file_names

import 'package:sales_records_app/models/database.dart';

class TransactionWithProduct {
  final Transaction transaction;
  final MyProduct myProduct;
  TransactionWithProduct(this.transaction, this.myProduct);
}
