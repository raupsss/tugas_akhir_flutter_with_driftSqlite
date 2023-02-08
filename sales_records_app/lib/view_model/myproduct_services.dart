import 'package:sales_records_app/models/database.dart';

class MyProductServices {
  
  final AppDb database = AppDb();

  Future insert(String nameProduct, String stock, String unitPrice) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.myProducts).insertReturning(
          MyProductsCompanion.insert(
            nameProduct: nameProduct,
            stock: int.parse(stock),
            unitPrice: int.parse(unitPrice),
            createdAt: now,
            updatedAt: now,
          ),
        );
    print(row.toString());
  }

  Future<List<MyProduct>> getAllProduct() async {
    return await database.getAllProductRepo();
  }

  Future update(int myProductId, String newNameProduct, int newStock,
      int newUnitPrice) async {
    await database.updateMyProductRepo(
        myProductId, newNameProduct, newStock, newUnitPrice);
  }
}