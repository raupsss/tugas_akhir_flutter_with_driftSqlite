import 'package:flutter/material.dart';
import 'package:sales_records_app/views/shared/shared.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
    required this.nameProduct,
    required this.purchaseTime,
    required this.quantity,
    required this.price,
  });
  final String nameProduct;
  final String purchaseTime;
  final int quantity;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameProduct,
                    style: blackTextStyle.copyWith(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    purchaseTime,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Text("qty : ${quantity.toString()}"),
              Text("Rp ${price.toString()}"),
            ],
          )),
    );
  }
}
