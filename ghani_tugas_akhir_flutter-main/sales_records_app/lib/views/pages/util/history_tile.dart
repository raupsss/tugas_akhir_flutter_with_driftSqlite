// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_records_app/models/database.dart';
import 'package:sales_records_app/models/transactionWithProduct_model.dart';
import 'package:sales_records_app/views/shared/shared.dart';

class HistoryTile extends StatefulWidget {
  const HistoryTile({
    super.key,
    required this.nameProduct,
    required this.purchaseTime,
    required this.quantity,
    required this.price,
  });
  final String nameProduct;
  final DateTime purchaseTime;
  final int quantity;
  final int price;

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController inputQuantity = TextEditingController();
  TextEditingController inputDate = TextEditingController();
  TextEditingController totalPrice = TextEditingController();
  MyProduct? selectedProduct;

  AppDb database = AppDb();

  Future<List<MyProduct>> getAllProduct() async {
    return await database.getAllProductRepo();
  }

  // Future update(int transactionId)

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
                  widget.nameProduct,
                  style: blackTextStyle.copyWith(
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  widget.purchaseTime.toString(),
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            Text("qty : ${widget.quantity.toString()}"),
            Text("Rp ${widget.price.toString()}"),
            InkWell(
              onTap: (() {
                // awesomeDialogWidget(context).show();
                // updateHistory(snap)

              }),
              child: const Icon(Icons.edit_note),
            ),
          ],
        ),
      ),
    );
  }

  AwesomeDialog updateHistory(TransactionWithProduct transactionWithProduct){

    selectedProduct = transactionWithProduct.myProduct;
    inputQuantity.text = transactionWithProduct.transaction.quantity.toString();
    inputDate.text = DateFormat("yyyy-MM-dd")
        .format(transactionWithProduct.transaction.transactionDate);

    return AwesomeDialog(
      context: context,
      isDense: true,
      showCloseIcon: true,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Transaction",
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: getAllProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        //content

                        return DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'Select Your Product',
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          items: snapshot.data!
                              .map(
                                (MyProduct item) => DropdownMenuItem<MyProduct>(
                                  value: item,
                                  child: Text(
                                    item.nameProduct,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            selectedProduct = value;
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No Data"),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text("Loading..."),
                      );
                    }
                  }
                },
              ),
              // TextButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       _formKey.currentState!.save();
              //     }
              //   },
              //   child: const Text('Submit Button'),
              // ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: inputQuantity,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Quantity cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Quantity',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      controller: inputDate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Date cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Entry Date",
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          print(
                              pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(
                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          print(
                              formattedDate); //formatted date output using intl package =>  2022-07-04
                          //You can format date as per your need

                          setState(() {
                            inputDate.text =
                                formattedDate; //set foratted date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Total Price = Rp 0",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      btnOk: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.green),
            ),
          ),
        ),
        onPressed: () {
          // Edit Transaction
        },
        child: const Text(
          "Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

    

}
