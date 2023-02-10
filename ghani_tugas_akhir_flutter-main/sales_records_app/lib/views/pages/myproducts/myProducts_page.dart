// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print
import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sales_records_app/models/database.dart';
import 'package:sales_records_app/view_model/myproduct_services.dart';
import 'package:sales_records_app/views/pages/util/dropdown.dart';
import 'package:sales_records_app/views/shared/shared.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
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

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  final AppDb database = AppDb();

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
          if (_formKey.currentState!.validate()) {
            if (myProduct == null) {
              MyProductServices().insert(
                inputNewProduct.text,
                inputStock.text,
                inputUnitPrice.text,
              );
              inputNewProduct.clear();
              inputStock.clear();
              inputUnitPrice.clear();
            } else {
              MyProductServices().update(
                myProduct.id,
                inputNewProduct.text,
                int.parse(inputStock.text),
                int.parse(
                  inputUnitPrice.text,
                ),
              );
              inputNewProduct.clear();
              inputStock.clear();
              inputUnitPrice.clear();
            }
            // Navigator.of(context, rootNavigator: true).pop('dialog');
            Navigator.pop(context);
            setState(() {});
          }
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

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullUp: true,
      child: SafeArea(
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
                              openDialog(null, "Add Product").show();
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name\nProduct"),
                          SizedBox(
                            width: 50,
                          ),
                          Text("Stock"),
                          SizedBox(
                            width: 40,
                          ),
                          Text("Unit Price"),
                        ],
                      ),
                      Expanded(
                        child: FutureBuilder<List<MyProduct>>(
                          future: MyProductServices().getAllProduct(),
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
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            // color: primaryColor,
                                            bottom: BorderSide(
                                              //                   <--- left side
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![index].nameProduct,
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data![index].stock}",
                                              style: blackTextStyle.copyWith(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Text(
                                              "Rp ${snapshot.data![index].unitPrice}",
                                              style: blackTextStyle.copyWith(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      openDialog(
                                                              snapshot
                                                                  .data![index],
                                                              "Edit Product")
                                                          .show();
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.warning,
                                                        headerAnimationLoop:
                                                            false,
                                                        animType: AnimType
                                                            .bottomSlide,
                                                        title:
                                                            'Delete ${snapshot.data![index].nameProduct} from My Product ?',
                                                        desc:
                                                            'If you delete it, it will delete the entire transaction history of this product ! Are you sure ?',
                                                        buttonsTextStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        showCloseIcon: true,
                                                        btnOk: TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .red),
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            database
                                                                .deleteMyProductRepo(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .id);
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                            // FirebaseAuth
                                                            //     .instance
                                                            //     .signOut();
                                                          },
                                                          child: const Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        btnCancel: TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white),
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                      ).show();
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
      ),
    );
  }
}
