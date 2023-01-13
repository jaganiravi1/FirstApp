//import 'dart:html';

import 'package:application/Authntication/auth.dart';
import 'package:application/model/customer.dart';
import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:application/ui/screens/dashboard/dashboard.dart';
import 'package:application/ui/screens/login_page/login_page.dart';
import 'package:application/user_preferences/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utilites/border_dec.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  AuthService _authService = AuthService();
  var _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isShowPass = false;
  bool isShowPass1 = false;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          //appBar: AppBar(title: Text("Cricket"),centerTitle: true,backgroundColor: Colors.blueAccent,),
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      StringManager.signup,
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                const Text(StringManager.createNewAcc,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      cursorColor: ColorManager.secondary,
                      controller: _usernamecontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorManager.secondary,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        prefixIcon:
                            Icon(Icons.person, color: ColorManager.secondary),
                        hintText: StringManager.Username,
                        //errorText: 'Invalid Email',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 2, color: ColorManager.secondary)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.red)),

                        labelText: StringManager.Username,
                        labelStyle: TextStyle(color: ColorManager.secondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return StringManager.required;
                        }

                        return null;
                      }),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      cursorColor: ColorManager.secondary,
                      controller: _emailcontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CommonUtilites.getInputDec(
                          StringManager.email,
                          Icons.email,
                          StringManager.email),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return StringManager.required;
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return StringManager.validEmail;
                        }
                        return null;
                      }),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      cursorColor: ColorManager.secondary,
                      controller: _pass,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return StringManager.required;
                        }
                        if (value.length <= 6) {
                          return StringManager.passwordCondition;
                        }
                      },
                      obscureText: !isShowPass,
                      decoration: CommonUtilites.getPassInputDec(
                          StringManager.password,
                          isLocked: isShowPass,
                          Icons.lock,
                          StringManager.password, () {
                        setState(() {
                          if (isShowPass) {
                            isShowPass = false;
                          } else {
                            isShowPass = true;
                          }
                        });
                      })),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: _confirmpass,
                      cursorColor: ColorManager.secondary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return StringManager.required;
                        }
                        if (value != _pass.text) {
                          return StringManager.passwordNotMatch;
                        }
                        return null;
                      },
                      obscureText: !isShowPass1,
                      decoration: CommonUtilites.getPassInputDec(
                          StringManager.confirmPass,
                          isLocked: isShowPass1,
                          Icons.lock,
                          StringManager.confirmPass, () {
                        setState(() {
                          if (isShowPass1) {
                            isShowPass1 = false;
                          } else {
                            isShowPass1 = true;
                          }
                        });
                      })),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      _authService.createNewAccount(email: _emailcontroller.text, userName: _usernamecontroller.text, password: _pass.text,context: context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorManager.primary,
                      ),
                      child: Center(
                          child: Container(
                        child: isLoading
                            ? Container(
                                height: 28,
                                child: const SpinKitCircle(
                                  color: Colors.white,
                                  size: 36,
                                ))
                            : const Text(
                                StringManager.signup,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                      )),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                const Text(
                  StringManager.or,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final UserCredential = AuthService().signInWithGoogle();
                    if (UserCredential != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(StringManager.wrong)));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorManager.secondary,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                IconAssets.ic_google,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              StringManager.googleSignin,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(StringManager.alreadyAcc,
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 14)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      },
                      child: Text(
                        StringManager.loginText,
                        style: TextStyle(
                            color: ColorManager.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
