import 'package:application/Pages/Dashboard.dart';
import 'package:application/Pages/ResetPass.dart';
import 'package:application/Pages/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowPass = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          //appBar: AppBar(title: Text("Cricket"),centerTitle: true,backgroundColor: Colors.blueAccent,),
          body: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //   Image.asset('lib/assets/logo2.png',

                // height: 100,
                // fit: BoxFit.fill,
                // ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Welcome Back",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                    SizedBox(width: 4),
                    Container(
                        width: 18,
                        height: 18,
                        child: Image.asset('lib/assets/wave_hand.webp')),
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
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        prefixIcon: Icon(Icons.email,
                            color: Theme.of(context).colorScheme.secondary),
                        hintText: 'Email',
                        //errorText: 'Invalid Email',
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.red)),

                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*required';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Enter a valid email!';
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
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '*required';
                      }
                      if (value.length <= 6) {
                        return 'Password must be contain atleast 6 characters';
                      }
                    },
                    obscureText: !isShowPass,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,
                          color: Theme.of(context).colorScheme.secondary),
                      suffixIcon: InkWell(
                        child: Icon(
                            isShowPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).colorScheme.secondary),
                        onTap: () {
                          setState(() {
                            if (isShowPass) {
                              isShowPass = false;
                            } else {
                              isShowPass = true;
                            }
                          });
                        },
                      ),
                      hintText: 'Password',
                      //errorText: 'Invalid Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.secondary)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.secondary)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),

                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPass()));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
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

                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: _emailcontroller.text,
                                password: _pass.text);
                        if (userCredential.user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Usernot found!!')));
                          setState(() {
                            isLoading = false;
                          });
                        } else if (e.code == "wrong-password") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Wrong Password!!')));
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        print(e);
                      }

                      //
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor
                        // gradient: const LinearGradient(
                        //     begin: Alignment.centerLeft,
                        //     end: Alignment.centerRight,
                        //     colors: [
                        //       Colors.tealAccent,
                        //       Colors.blue,
                        //       Colors.pinkAccent,
                        //     ]),
                        ),
                    child: Center(
                        child: isLoading
                            ? Container(
                                height: 8,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                  ),
                ),
                //SizedBox(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
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
                          'SignUp',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
