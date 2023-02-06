import 'dart:io';

import 'package:drift/drift.dart';
// These imports are used to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sales_records_app/models/products_model.dart';
import 'package:sales_records_app/models/transactions_model.dart';

part 'database.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  tables: [MyProducts, Transactions],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<MyProduct>> getAllProductRepo() async {
    return await (select(myProducts)).get();
  }

  Future updateMyProductRepo(
      int id, String newNameProduct, int newStock, int newUnitPrice) async {
    return await (update(myProducts)..where((tbl) => tbl.id.equals(id))).write(
      MyProductsCompanion(
        nameProduct: Value(newNameProduct),
        stock: Value(newStock),
        unitPrice: Value(newUnitPrice),
      ),
    );
  }

  Future deleteMyProductRepo(int id) async {
    return (delete(myProducts)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
