import 'package:application/resources/string_manager.dart';
import 'package:application/user_preferences/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/customer.dart';
import '../ui/screens/dashboard/dashboard.dart';

class AuthService {
  //Google SignIn
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      // ignore: await_only_futures
      final credential = await GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

//create a new account
  createNewAccount(
      {required String email,
      required String userName,
      required String password,
      context}) async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = usercredential.user;

      await user?.updateDisplayName(userName);
      await UserPreferences.saveLoginUserInfo(ModelCustomer(
                            id: user!.uid,
                            name: userName,
                            email: email));
                            print("Signup EMAIL:${await UserPreferences.getUserEmail()}");

      if (usercredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print(StringManager.userExists);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(StringManager.userExists)));
      }
    }
  }

  //for login
  loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await UserPreferences.saveLoginUserInfo(ModelCustomer(
          email: email,
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName));
          print("Login Email  :  ${await UserPreferences.getUserEmail()}");

      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(StringManager.userNotFound)));
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(StringManager.wrongPassword)));
      }
    } catch (e) {
      print(e);
    }
  }
}

// class Auth {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   User? get currentUser => _firebaseAuth.currentUser;

//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

//   Future<void> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     await _firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//   }

//   Future<void> createUserWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email, password: password);
//   }
// //signout
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
// // }
// }
