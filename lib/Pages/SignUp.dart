import 'package:application/Pages/LoginPage.dart';
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
  final TextEditingController _pass = TextEditingController();
   final TextEditingController _confirmpass = TextEditingController();
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
              Text("Welcome Back",
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,color: Colors.black45,),
                            hintText: "Username", border: InputBorder.none),
                            validator: (value) {
                              if(value!.isEmpty){
                                    return 'Enter valid username!';
                                  }return null;
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,color: Colors.black45,),
                            hintText: "Email", border: InputBorder.none),
                            validator: (value) {
                              if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)){
                                    return 'Enter valid email!';
                                  }return null;
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
                        controller: _pass,
                        validator: (value) {
                          if(value!.isEmpty || value.length<=6){
                            return "Password mus be contains 6 characters";
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,color: Colors.black45,),
                            suffixIcon: Icon(Icons.visibility),
                            hintText: "Password",
                            border: InputBorder.none),
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
                        controller: _confirmpass,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Empty';

                          }if(value != _pass.text){
                            return 'Password Does not match';
                          }return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,color: Colors.black45,),
                            suffixIcon: Icon(Icons.visibility),
                            hintText: "Confirm Password",
                            border: InputBorder.none),
                      ),
                    ),
                    ),
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  }
                },
                child: Container(
                    
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Colors.tealAccent,Colors.blue, Colors.pinkAccent,])),
                  child: Center(child: Text('SignUp',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
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
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
              
                          }, child: Text('Login',style: TextStyle(color: Colors.pink),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}