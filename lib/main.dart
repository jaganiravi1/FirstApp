import 'package:application/Pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  Color color1 = Color(0xFF004f88);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.yellow,
            secondary: Color(0xFF0d5592),
          ),

          //brightness: Brightness.dark,
          primaryColor: Color(0xFFff6b35),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )),
    );
  }
}
