import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resources/string_manager.dart';
import '../screens/login_page/login_page.dart';

class AlertDialogBox {
  static signoutAleartDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        StringManager.exitDialog,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              onPressed: () {
                FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
              child: const Text(
                StringManager.yes,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  side: MaterialStatePropertyAll(BorderSide(
                    color: Colors.redAccent,
                  )),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                StringManager.no,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ],
    );
  }

  static exitAppAleartDialog(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: const Text(
          StringManager.exitDialog,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                StringManager.yes,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  side: MaterialStatePropertyAll(BorderSide(
                    color: Colors.redAccent,
                  )),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                StringManager.no,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ],
    );
  }
}
