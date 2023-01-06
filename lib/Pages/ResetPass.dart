import 'package:application/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            child: Container(
                child: Icon(
              Icons.keyboard_arrow_left,
              color: Theme.of(context).colorScheme.secondary,
              size: 34,
            )),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => LoginPage())));
            },
          ),
        ),
        body: Column(children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Column(
                children: [
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'The reset password link will be provided in your email',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: _email,
              decoration: InputDecoration(
                label: Text('Email'),
                hintText: 'Enter your email',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
                  backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.secondary,
                  )),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _email.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Successfully reset password link sent to your email')));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please enter valid email')));
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Reset'),
              ))
        ]),
      ),
    );
  }
}
