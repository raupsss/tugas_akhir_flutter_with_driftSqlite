// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter_new/flutter.dart'
    as charts;
import 'package:flutter/material.dart';

class OrderStats {
  final DateTime dateTime;
  final int index;
  final int orders;
  charts.Color? barColor;

  OrderStats({
    required this.dateTime,
    required this.index,
    required this.orders,
    this.barColor,
  }) {
    barColor = charts.ColorUtil.fromDartColor(Colors.black);
  }

  factory OrderStats.fromSnapshot(DocumentSnapshot snap, int index) {
    return OrderStats(
        dateTime: snap['date'].toDate(),
        index: index,
        orders: snap['total_income']);
  }

  static final List<OrderStats> data = [
    OrderStats(
      dateTime: DateTime.now(),
      index: 0,
      orders: 10,
    ),
    OrderStats(
      dateTime: DateTime.now(),
      index: 2,
      orders: 20,
    ),
    OrderStats(
      dateTime: DateTime.now(),
      index: 3,
      orders: 90,
    ),
    OrderStats(
      dateTime: DateTime.now(),
      index: 4,
      orders: 70,
    ),
    OrderStats(
      dateTime: DateTime.now(),
      index: 5,
      orders: 90,
    ),
  ];
}
