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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          hintText: "Username", border: InputBorder.none),
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility),
                          hintText: "Confirm Password",
                          border: InputBorder.none),
                    ),
                  ),
                  ),
            ),
            SizedBox(height: 12),
            Container(

              height: 40,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Colors.tealAccent,Colors.blue, Colors.pinkAccent,])),
              child: Center(child: Text('SignUp',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
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
    );
  }
}