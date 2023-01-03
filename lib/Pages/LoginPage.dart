import 'package:application/Pages/Dashboard.dart';
import 'package:application/Pages/SignUp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowPass = false;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          //appBar: AppBar(title: Text("Cricket"),centerTitle: true,backgroundColor: Colors.blueAccent,),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              const Text("Welcome Back",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
              const SizedBox(
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
                        
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email,color: Colors.black45,),
                            hintText: "Email", border: InputBorder.none),
                        // onFieldSubmitted: (value) {
                        //   //validator
                        // },
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                      ),
                    )),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [BoxShadow(color: Colors.grey.shade300)]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isEmpty || value.length<=6){
                            return 'Password must be contain more than 6 characters';
                          }
                        },
                        obscureText: !isShowPass,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,color: Colors.black45,),
                            suffixIcon: InkWell(
                              child: Icon(isShowPass
                                  ? Icons.visibility_off
                                  : Icons.visibility),
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
                            hintText: "Password",
                            border: InputBorder.none),
                      ),
                    )),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
                  }
                },
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.tealAccent,
                            Colors.blue,
                            Colors.pinkAccent,
                          ])),
                  child: const Center(
                      child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: Colors.pink),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
