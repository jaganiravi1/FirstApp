import 'dart:async';

import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../dashboard/dashboard.dart';
import '../login_page/login_page.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          if (mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          }
        } else {
          if (mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        }
        ;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: ColorManager.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.splashLogo,
              height: 150,
              fit: BoxFit.fill,
            ),
            // Icon(Icons.music_note, color: Colors.white, size: 100),
            // SizedBox(
            //   height: 1,
            // ),
            Text(
              StringManager.splashscreenText,
              style: TextStyle(
                color: ColorManager.white,
                fontStyle: FontStyle.italic,
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
