import 'package:application/Authntication/reset_pass.dart';
import 'package:application/ui/utilites/common_utilities.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:flutter/material.dart';
import '../login_page/login_page.dart';

class ResetPassScreen extends StatefulWidget {
  static String id = 'resetPass';
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final ResetPass _resetPass = ResetPass();
  // ignore: prefer_final_fields
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          // ignore: avoid_unnecessary_containers
          child: Container(
              child: Icon(
            Icons.keyboard_arrow_left,
            color: ColorManager.secondary,
            size: 34,
          )),
          onTap: () {
            Navigator.pushReplacementNamed(context, LoginPage.id);
          },
        ),
      ),
      body: Column(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                Text(
                  StringManager.resetPass,
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                // ignore: prefer_const_constructors
                SizedBox(height: 5),
                Text(
                  StringManager.resetPassSubTitle,
                  style: TextStyle(
                      color: ColorManager.secondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: _email,
            decoration: CommonUtilites.getInputDec(
                StringManager.email, Icons.email, StringManager.email),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              backgroundColor: MaterialStatePropertyAll(
                ColorManager.secondary,
              ),
            ),
            onPressed: () async {
              await ResetPass.resetPassword(
                  email: _email.text, context: context);
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(StringManager.resetPass),
            ))
      ]),
    );
  }
}
