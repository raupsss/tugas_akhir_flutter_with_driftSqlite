// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sales_records_app/models/database.dart';
import 'package:sales_records_app/view_model/provider.dart';
import 'package:sales_records_app/view_model/myproduct_services.dart';
import 'package:sales_records_app/view_model/transactions_services.dart';
import 'package:sales_records_app/views/pages/myproducts/myProducts_page.dart';
import 'package:sales_records_app/views/shared/shared.dart';
import 'package:calendar_appbar/calendar_appbar.dart';

import 'widget/main_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController inputQuantity = TextEditingController();
  TextEditingController inputDate = TextEditingController();
  // TextEditingController totalPrice = TextEditingController();
  MyProduct? selectedProduct;
  int totalPrice = 0;

  @override
  void dispose() {
    inputQuantity.dispose();
    inputDate.dispose();
    // totalPrice.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    updateView(0, DateTime.now());
    inputDate.text = "";
  }

  late DateTime selectedDate;
  late List<Widget> _children;
  late int currentIndex;

  void updateView(int index, DateTime? date) {
    setState(() {
      if (date != null) {
        selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      }

      currentIndex = index;
      _children = [
        MainScreen(selectedDate: selectedDate),
        const MyProductsPage(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              padding: 0.0,
              backButton: false,
              accent: primaryColor,
              onDateChanged: (value) {
                setState(() {
                  selectedDate = value;
                  updateView(0, value);
                });
              },
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : null,
      backgroundColor: primaryColor,
      floatingActionButton: Visibility(
        visible: (currentIndex == 0) ? true : false,
        child: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: (() async {
            await awesomeDialogWidget(context).show();
            setState(() {});
          }),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Transaction',
            tooltip: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Products',
            tooltip: "",
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.green,
        onTap: (val) {
          updateView(val, null);
        },
      ),
      body: _children[currentIndex],
    );
  }

  AwesomeDialog awesomeDialogWidget(BuildContext context) {
    inputQuantity.clear();
    inputDate.clear();
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
          child: ChangeNotifierProvider<SharedProvider>(
            create: (context) => SharedProvider(),
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
                            validator: (value) {
                              if (value == null) {
                                return "Name Product cannot be empty";
                              }
                              return null;
                            },
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
                                  (MyProduct item) =>
                                      DropdownMenuItem<MyProduct>(
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Consumer<SharedProvider>(
                      builder: (BuildContext context, function, Widget? child) {
                        return Flexible(
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
                            onChanged: (value) {
                              if (value == "") {
                                value = "0";
                              }
                              function.changeTotalPrice(
                                  selectedProduct!.unitPrice *
                                      int.parse(value));
                              print(totalPrice);
                            },
                          ),
                        );
                      },
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
                Consumer<SharedProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    print(value.totalPrice);
                    return Text(
                      "Total Price = Rp ${value.totalPrice}",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    );
                  },
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
          if (_formKey.currentState!.validate()) {
            TransactionServices().insert(
              selectedProduct!.nameProduct,
              int.parse(inputQuantity.text),
              DateTime.parse(inputDate.text),
              int.parse(inputQuantity.text) * selectedProduct!.unitPrice,
              selectedProduct!.id,
            );
            // MyProduct? myProduct;
            // MyProductServices().update(
            //     selectedProduct!.id,
            //     selectedProduct!.nameProduct,
            //     myProduct!.stock - int.parse(inputQuantity.text),
            //     selectedProduct!.unitPrice);
            Navigator.pop(context);
            setState(() {});
          }
          // print(selectedProduct!.nameProduct);

          // Add Transaction
        },
        child: const Text(
          "Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
