import 'package:drift/drift.dart';

@DataClassName('MyProduct')
class MyProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameProduct => text().withLength(max: 128)();
  IntColumn get stock => integer()();
  IntColumn get unitPrice => integer()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
