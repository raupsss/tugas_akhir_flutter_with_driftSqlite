// ignore_for_file: avoid_print

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sales_records_app/models/database.dart';
import 'package:sales_records_app/models/transactionWithProduct_model.dart';
import 'package:sales_records_app/view_model/myproduct_services.dart';
import 'package:sales_records_app/view_model/provider.dart';
import 'package:sales_records_app/view_model/transactions_services.dart';
import 'package:sales_records_app/views/pages/home/chart_page.dart';
import 'package:sales_records_app/views/pages/util/dropdown.dart';
import 'package:sales_records_app/views/shared/shared.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);
  final DateTime selectedDate;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AppDb database = AppDb();

  final _formKey = GlobalKey<FormState>();

  TextEditingController inputQuantity = TextEditingController();
  TextEditingController inputDate = TextEditingController();
  TextEditingController totalPrice = TextEditingController();
  MyProduct? selectedProduct;

  AwesomeDialog updateHistory(TransactionWithProduct transactionWithProduct) {
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
                "Edit Transaction",
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: MyProductServices().getAllProduct(),
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
                          value: selectedProduct,
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
                          onChanged: (val) {
                            selectedProduct = val;
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
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(
                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
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
          TransactionServices().update(
            transactionWithProduct.transaction.id,
            selectedProduct!.id,
            int.parse(inputQuantity.text),
            DateTime.parse(inputDate.text),
            selectedProduct!.nameProduct,
            int.parse(inputQuantity.text) * 1000,
          );
          setState(() {});
          Navigator.pop(context);
        },
        child: const Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ),
      ),
      btnCancel: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        onPressed: () {
          // database.deleteTransactionRepo()
          // database.deleteMyProductRepo(snapshot.data![index].id);
          // setState(() {});
          // delete(getAllProduct().)
          Navigator.pop(context);
        },
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<int> a = [];
  void atest(snapshot) {
    a.clear();
    snapshot.data!.forEach((element) {
      a.add(element.transaction.totalPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // height: 500,
        padding: const EdgeInsets.all(10.0),

        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: ChangeNotifierProvider<SharedProvider>(
          create: (context) => SharedProvider(),
          child: StreamBuilder<List<TransactionWithProduct>>(
              stream: database.getTransactionByDateRepo(widget.selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      atest(snapshot);
                      print(a);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  // margin: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Icon(
                                                  Icons.monetization_on,
                                                  color: Colors.green,
                                                  size: 30,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Income : ",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rp  ${a.reduce((a, b) => a + b)}",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Chart(),
                                            ),
                                          );
                                        }),
                                        child: const Icon(
                                          Icons.insert_chart_outlined_outlined,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: secondaryColor,
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "History",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const Icon(Icons.history),
                                ],
                              ),
                              const DropdownWidget(iconColor: Colors.black),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data![index]
                                                      .myProduct.nameProduct,
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index]
                                                      .transaction
                                                      .transactionDate
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                "qty : ${snapshot.data![index].transaction.quantity.toString()}"),
                                            Text(
                                                "Rp ${snapshot.data![index].transaction.totalPrice.toString()}"),
                                            InkWell(
                                              onTap: (() {
                                                // awesomeDialogWidget(context).show();
                                                updateHistory(
                                                        snapshot.data![index])
                                                    .show();
                                              }),
                                              child:
                                                  const Icon(Icons.edit_note),
                                            ),
                                            InkWell(
                                              onTap: (() {
                                                database.deleteTransactionRepo(
                                                  snapshot.data![index]
                                                      .transaction.id,
                                                );
                                              }),
                                              child: const Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
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
              }),
        ),
      ),
    );
  }
}
