import 'package:drift/drift.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameProduct => text().withLength(max: 128)();
  IntColumn get productId => integer()();
  IntColumn get quantity => integer()();
  IntColumn get totalPrice => integer()();
  DateTimeColumn get entryTime => dateTime()();
  DateTimeColumn get transactionDate => dateTime()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
