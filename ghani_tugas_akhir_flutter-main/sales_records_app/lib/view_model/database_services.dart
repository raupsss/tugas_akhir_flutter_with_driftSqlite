import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_records_app/models/order_stats_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<OrderStats>> getOrderStats() {
    return _firebaseFirestore
        .collection('transaction_chart')
        .orderBy('date')
        .get()
        .then((querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((e) => OrderStats.fromSnapshot(e.value, e.key))
            .toList());
  }
}
