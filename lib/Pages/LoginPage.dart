import 'package:application/Pages/SignUp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  'Login',
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
                  )),
            ),
            SizedBox(height: 12),
            Container(

              height: 40,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Colors.tealAccent,Colors.blue, Colors.pinkAccent,])),
              child: Center(child: Text('LOGIN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
            ),
            //SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 14)),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
            
                        }, child: Text('SignUp',style: TextStyle(color: Colors.pink),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
