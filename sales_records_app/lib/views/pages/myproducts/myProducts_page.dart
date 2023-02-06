// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print
import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_records_app/models/database.dart';
import 'package:sales_records_app/views/pages/util/dropdown.dart';
import 'package:sales_records_app/views/shared/shared.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  final AppDb database = AppDb();

  Future insert(String nameProduct, String stock, String unitPrice) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.myProducts).insertReturning(
          MyProductsCompanion.insert(
            nameProduct: nameProduct,
            stock: int.parse(stock),
            unitPrice: int.parse(unitPrice),
            createdAt: now,
            updatedAt: now,
          ),
        );
    print(row.toString());
  }

  Future<List<MyProduct>> getAllProduct() async {
    return await database.getAllProductRepo();
  }

  Future update(int myProductId, String newNameProduct, int newStock,
      int newUnitPrice) async {
    await database.updateMyProductRepo(
        myProductId, newNameProduct, newStock, newUnitPrice);
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController inputNewProduct = TextEditingController();
  TextEditingController inputStock = TextEditingController();
  TextEditingController inputUnitPrice = TextEditingController();

  @override
  void dispose() {
    inputNewProduct.dispose();
    inputStock.dispose();
    inputUnitPrice.dispose();

    super.dispose();
  }

  AwesomeDialog openDialog(MyProduct? myProduct, String titleDialog) {
    if (myProduct != null) {
      inputNewProduct.text = myProduct.nameProduct;
      inputStock.text = myProduct.stock.toString();
      inputUnitPrice.text = myProduct.unitPrice.toString();
    } else {
      inputNewProduct.text = "";
      inputStock.text = "";
      inputUnitPrice.text = "";
    }

    return AwesomeDialog(
      context: context,
      showCloseIcon: true,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                titleDialog,
                style: blackTextStyle.copyWith(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: inputNewProduct,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Product cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Name Product',
                ),
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
              TextFormField(
                controller: inputStock,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Stock cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Stock',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: inputUnitPrice,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Unit Price cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Unit Price  ',
                ),
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
          // Add New Product
          if (myProduct == null) {
            insert(inputNewProduct.text, inputStock.text, inputUnitPrice.text);
            inputNewProduct.clear();
            inputStock.clear();
            inputUnitPrice.clear();
          } else {
            update(myProduct.id, inputNewProduct.text,
                int.parse(inputStock.text), int.parse(inputUnitPrice.text));
            inputNewProduct.clear();
            inputStock.clear();
            inputUnitPrice.clear();
          }
          setState(() {});
          // Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.pop(context);
        },
        child: const Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateNow = DateFormat('dd MMM, yyyy').format(now);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, Admin !",
                          style: blackTextStyle.copyWith(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          formattedDateNow,
                          style: blackTextStyle.copyWith(
                              fontSize: 10.0, color: tertiaryColor),
                        ),
                      ],
                    ),
                    const DropdownWidget(
                      iconColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Product",
                          style: blackTextStyle.copyWith(
                            fontSize: 24.0,
                          ),
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.add,
                          ),
                          onTap: () {
                            // awesomeDialogWidget(context).show();
                            openDialog(null, "Add Product").show();
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: FutureBuilder<List<MyProduct>>(
                        future: getAllProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return Table(
                                      children: [
                                        const TableRow(
                                          children: [
                                            Text(
                                              "Name Product",
                                            ),
                                            Text("Stock"),
                                            Text("Unit Price"),
                                            Text(""),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text(
                                              snapshot.data![index].nameProduct,
                                            ),
                                            Text(
                                                "${snapshot.data![index].stock}"),
                                            Text(
                                                "Rp ${snapshot.data![index].unitPrice}"),
                                            Column(
                                              children: [
                                                TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.amber),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.amber),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // Navigator.pop(context);
                                                    openDialog(
                                                            snapshot
                                                                .data![index],
                                                            "Edit Product")
                                                        .show();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons.edit,
                                                      ),
                                                      Text(
                                                        "Edit",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        side: const BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // Navigator.pop(context);
                                                    database
                                                        .deleteMyProductRepo(
                                                            snapshot
                                                                .data![index]
                                                                .id);
                                                    setState(() {});
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "No Data",
                                    style: blackTextStyle,
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: Text(
                                  "Loading",
                                  style: blackTextStyle,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
