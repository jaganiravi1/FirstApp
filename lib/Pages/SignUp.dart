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
          body: SingleChildScrollView (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          color: Colors.pink,
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
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [BoxShadow(color: Colors.grey.shade300)]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextFormField(
                          controller: _usernamecontroller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black45,
                              ),
                              hintText: "Username",
                              border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter valid username!';
                            }
                            return null;
                          },
                        ),
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [BoxShadow(color: Colors.grey.shade300)]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextFormField(
                          controller: _emailcontroller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black45,
                              ),
                              hintText: "Email",
                              border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter valid email!';
                            }
                            return null;
                          },
                        ),
                      )),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [BoxShadow(color: Colors.grey.shade300)]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextFormField(
                        obscureText: !isShowPass,
                        controller: _pass,
                        validator: (value) {
                          if (value!.isEmpty || value.length <= 6) {
                            return "Password mus be contains 6 characters";
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black45,
                            ),
                            suffixIcon: InkWell(
                                child: Icon(isShowPass
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            hintText: "Password",
                            border: InputBorder.none),
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
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [BoxShadow(color: Colors.grey.shade300)]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextFormField(
                        obscureText: !isShowPass1,
                        controller: _confirmpass,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Empty';
                          }
                          if (value != _pass.text) {
                            return 'Password Does not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black45,
                            ),
                            suffixIcon: InkWell(
                                child: Icon(isShowPass1
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            hintText: "Confirm Password",
                            border: InputBorder.none),
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
                    ),
                  ),
                ),
                SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      UserCredential usercredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailcontroller.text, password: _pass.text);
                      if (usercredential.user != null) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Dashboard()));
                      }
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.tealAccent,
                              Colors.blue,
                              Colors.pinkAccent,
                            ])),
                    child: Center(
                        child: Text(
                      'SignUp',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                //SizedBox(height: 1),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black87
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
                          CircleAvatar(radius: 15,
                            backgroundColor: Colors.white,
                            
                            backgroundImage: AssetImage(
                              'lib/assets/google1.png',),
                          ),
                          SizedBox(width: 8),
                          // Container(
                          //   width: 20,
                          //   height: 20,
                          //   child: Image.asset('lib/assets/images.png',fit: BoxFit.contain),
                          //   ),
                          Text(
                            'Signup with Google',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          
                        ],
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
