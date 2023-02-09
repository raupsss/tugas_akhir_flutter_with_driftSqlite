// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_records_app/views/shared/shared.dart';

import '../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final inputName = TextEditingController();
  final inputEmail = TextEditingController();
  final inputPassword = TextEditingController();

  @override
  void dispose() {
    inputName.dispose();
    inputEmail.dispose();
    inputPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loginPage(context);
  }

  SafeArea loginPage(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          Image.asset(
            "assets/images/logo1-removebg.png",
            height: 350,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Welcome",
            style: primaryTextStyle,
          ),
          Text(
            "The best kind of food that God gives is here",
            style: blackTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width - 2 * defaultMargin,
            child: ElevatedButton(
              onPressed: () {
                modalLogin(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Login",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width - 2 * defaultMargin,
            child: ElevatedButton(
              onPressed: () {
                modalRegister(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: secondaryColor,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                "Register",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "All Right Reserved @2023 by Ghani",
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(color: primaryColor, fontSize: 11),
          )
        ],
      ),
    );
  }

  Future<dynamic> modalRegister(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: ((context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "REGISTER",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 30,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  "assets/images/close.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: inputName,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Username',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: inputName,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Email',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: inputName,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Password',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // DAFTAR ADMIN
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                          color: secondaryColor,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Register",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account ? ",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        modalLogin(context);
                                      },
                                      child: Text(
                                        "Login",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14,
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }

  Future<dynamic> modalLogin(BuildContext context) {
    Future signIn() async {
      showDialog(
        context: context,
        builder: ((context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: inputEmail.text,
          password: inputPassword.text,
        );
      } on FirebaseAuthException catch (e) {
        // print(e);
        // errorMessage = e.message!;
      }

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    bool passCheck = true;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: ((context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "LOGIN",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 30,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  "assets/images/close.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Form(
                            key: _formKey2,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Email cannot be empty";
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      return "Please insert correct Email";
                                    }
                                    return null;
                                  },
                                  controller: inputEmail,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Email',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: inputPassword,
                                  obscureText: passCheck,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    suffix: InkWell(
                                      onTap: (() {
                                        setState(
                                          () {
                                            passCheck = !passCheck;
                                          },
                                        );
                                      }),
                                      child: passCheck
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Password',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey2.currentState!.validate()) {
                                        Navigator.pop(context);
                                        signIn();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                          color: secondaryColor,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account ? ",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        modalRegister(context);
                                      },
                                      child: Text(
                                        "Register",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14,
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }
}
