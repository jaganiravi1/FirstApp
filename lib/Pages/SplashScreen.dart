import 'dart:async';

import 'package:flutter/material.dart';

import 'package:application/Pages/LoginPage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LoginPage()
            )
        )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.tealAccent,Colors.blue, Colors.pinkAccent,])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.music_note, color: Colors.white, size: 100),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Music",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
