
import 'package:application/resources/string_manager.dart';
import 'package:application/ui/screens/login_page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPass {
 static resetPassword ({required String email,required BuildContext context}) async {
    try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(StringManager.successfullyEmailSent)));
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(StringManager.validEmail)));
                  }
                }
  }
  
}