// ignore_for_file: prefer_final_fields

import 'package:application/Authntication/auth.dart';
import 'package:application/resources/assets_manager.dart';
import 'package:application/ui/screens/dashboard/dashboard.dart';
import 'package:application/ui/screens/resetpass_page/resetpass_page.dart';
import 'package:application/ui/screens/signup_page/signup_page.dart';
import 'package:application/ui/utilites/border_dec.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  AuthService _authService = AuthService();
  
  bool isShowPass = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoading1 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          //appBar: AppBar(title: Text("Cricket"),centerTitle: true,backgroundColor: Colors.blueAccent,),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Text(
                      StringManager.loginText,
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(StringManager.loginSubtitle,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                    const SizedBox(width: 4),
                    SizedBox(
                        width: 18,
                        height: 18,
                        child: Image.asset(IconAssets.ic_hand)),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: _emailcontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: ColorManager.secondary,
                      decoration: CommonUtilites.getInputDec(StringManager.loginText, Icons.email, StringManager.loginText),
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

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: _pass,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: ColorManager.secondary,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return StringManager.required;
                      }
                      if (value.length <= 6) {
                        return StringManager.passwordCondition;
                      }
                    },
                    obscureText: !isShowPass,
                    decoration: CommonUtilites.getPassInputDec(StringManager.password,isLocked:isShowPass , Icons.lock, StringManager.password, (){
                     setState(() {
                             if (isShowPass) {
                               isShowPass = false;
                             } else {
                               isShowPass = true;
                             }
                           });
                    })
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ResetPassScreen()));
                          },
                          child: Text(
                            StringManager.forgotPassword,
                            style: TextStyle(color: ColorManager.secondary),
                          )),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      await _authService.loginUser(email: _emailcontroller.text , password: _pass.text, context: context);

                      setState(() {
                        isLoading=false;
                      });

                      
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorManager.primary
                          
                          ),
                      child: Center(
                          child: isLoading
                              ? Container(
                                  height: 28,
                                  child: const SpinKitCircle(
                                    color: Colors.white,
                                    size: 36,
                                  ))
                              : const Text(
                                  StringManager.loginText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  StringManager.or,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                //duyiuwyf
                InkWell(
                  onTap: () async {
                    final userCredential = await AuthService()
                        .signInWithGoogle() as UserCredential;

                    if (UserCredential != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const Dashboard()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(StringManager.wrongPassword)));
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
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                IconAssets.ic_google,
                              ),
                            ),
                            SizedBox(width: 8),
                            Center(
                              child: isLoading1
                                  ? Container(
                                      child: const SpinKitCircle(
                                      color: Colors.white,
                                      size: 28,
                                    ))
                                  : (const Text(
                                      StringManager.googleSignin,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(StringManager.noAccount,
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 14)),
                    TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const SignupPage()));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()),
                              (route) => false);
                        },
                        child: Text(
                          StringManager.signup,
                          style: TextStyle(
                              color: ColorManager.secondary,
                              fontWeight: FontWeight.bold),
                        ))
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
