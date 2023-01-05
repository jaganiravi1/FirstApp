import 'package:application/Pages/Dashboard.dart';
import 'package:application/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isShowPass = false;
  bool isShowPass1 = false;
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
                      'SignUp',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Text("Create a new account",
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
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      controller: _usernamecontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        prefixIcon: Icon(Icons.person,
                            color: Theme.of(context).colorScheme.secondary),
                        hintText: 'Username',
                        //errorText: 'Invalid Email',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.red)),

                        labelText: 'Username',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*required';
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
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      controller: _emailcontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.red)),
                        focusColor: Colors.blueAccent,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
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
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    controller: _pass,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                      focusColor: Colors.blueAccent,
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: _confirmpass,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '*required';
                      }
                      if (value != _pass.text) {
                        return 'Password Does not match';
                      }
                      return null;
                    },
                    obscureText: !isShowPass1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,
                          color: Theme.of(context).colorScheme.secondary),
                      suffixIcon: InkWell(
                        child: Icon(
                            isShowPass1
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).colorScheme.secondary),
                        onTap: () {
                          setState(() {
                            if (isShowPass1) {
                              isShowPass1 = false;
                            } else {
                              isShowPass1 = true;
                            }
                          });
                        },
                      ),
                      hintText: 'Confirm Password',
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
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                      focusColor: Colors.blueAccent,
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading=true;
                      });
                      try {
                        UserCredential usercredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: _emailcontroller.text,
                                password: _pass.text);

                        if (usercredential.user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          print('user already exists');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User already exists')));
                        }
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        // gradient: LinearGradient(
                        //     begin: Alignment.centerLeft,
                        //     end: Alignment.centerRight,
                        //     colors: [
                        //       Colors.tealAccent,
                        //       Colors.blue,
                        //       Colors.pinkAccent,
                        //     ]),
                      ),
                      child: Center(
                          child: Container(
                            child: isLoading?Container(height: 10, child: CircularProgressIndicator(color: Colors.white,)): Text(
                        'SignUp',
                        style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'OR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).colorScheme.secondary,
                        // gradient: LinearGradient(
                        //     begin: Alignment.centerLeft,
                        //     end: Alignment.centerRight,
                        //     colors: [
                        //       Colors.tealAccent,
                        //       Colors.blue,
                        //       Colors.pinkAccent,
                        //     ])
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                'lib/assets/google1.png',
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Signup with Google',
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
                    Text("Already have an account?",
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
                        'Login',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
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
