// import "package:get/get.dart";
// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:sales_records_app/models/order_stats_model.dart';
import 'package:sales_records_app/view_model/database_services.dart';

class OrderStatsController extends GetxController {
  final DatabaseService database = DatabaseService();

  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit() {
    stats.value = database.getOrderStats();
    super.onInit();
  }
}
