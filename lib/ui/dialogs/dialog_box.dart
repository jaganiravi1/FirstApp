import 'package:application/resources/color_manager.dart';
import 'package:application/user_preferences/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resources/string_manager.dart';
import '../screens/login_page/login_page.dart';

class AlertDialogBox {
  static signoutAleartDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        StringManager.singoutDialog,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ColorManager.darkred)),
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                await UserPreferences.clearDetailsOnSignOut();
                

                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
              child:Text(
                StringManager.yes,
                style:
                    TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style:  ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  side: MaterialStatePropertyAll(BorderSide(

                    color: ColorManager.darkred
                  )),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                StringManager.no,
                style: TextStyle(color: ColorManager.darkred),
              ),
            )
          ],
        ),
      ],
    );
  }

  static exitAppAleartDialog(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          StringManager.exitDialog,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ColorManager.darkred)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                StringManager.yes,
                style:
                    TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  side: MaterialStatePropertyAll(BorderSide(
                    color: ColorManager.darkred,
                  )),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () {
                Navigator.pop(context);
              },
              child:Text(
                StringManager.no,
                style: TextStyle(color: ColorManager.darkred),
              ),
            )
          ],
        ),
      ],
    );
  }
}
