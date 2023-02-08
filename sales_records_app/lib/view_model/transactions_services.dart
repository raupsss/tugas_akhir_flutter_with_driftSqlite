import 'package:sales_records_app/models/database.dart';

class TransactionServices {
  
final AppDb database = AppDb();

  Future insert(String nameProduct, int quantity, DateTime date, int totalPrice,
      int productId) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.transactions).insertReturning(
          TransactionsCompanion.insert(
            nameProduct: nameProduct,
            quantity: quantity,
            totalPrice: totalPrice,
            entryTime: now,
            transactionDate: date,
            createdAt: now,
            updatedAt: now,
            productId: productId,
          ),
        );
    print(row.toString());
  }

  Future delete(int id) async {
    return await database.deleteTransactionRepo(id);
  }

  Future update(int transactionId, int productId, int quantity,
      DateTime transactionDate, String nameProduct, int newTotalPrice) async {
    return await database.updateTransactionRepo(transactionId, quantity,
        productId, transactionDate, nameProduct, newTotalPrice);
  }
}