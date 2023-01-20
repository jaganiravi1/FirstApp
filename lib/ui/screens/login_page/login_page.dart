import 'package:application/Authntication/auth.dart';
import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/styles_manager.dart';
import 'package:application/ui/screens/dashboard/dashboard.dart';
import 'package:application/ui/screens/resetpass_page/resetpass_page.dart';
import 'package:application/ui/screens/signup_page/signup_page.dart';
import 'package:application/ui/utilites/common_utilities.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:application/ui/utilites/button_theme.dart';
import 'package:application/ui/validator/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  AuthService _authService = AuthService();

  bool isShowPass = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoading1 = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        //appBar: AppBar(title: Text("Cricket"),centerTitle: true,backgroundColor: Colors.blueAccent,),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Text(StringManager.loginText,
                      style: getBoldStyle(
                          color: ColorManager.primary, fontSize: 30)),
                ),
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringManager.loginSubtitle,
                      style: getRegularStyle(
                          color: ColorManager.lightGrey, fontSize: 16)),
                  const SizedBox(width: 4),
                  SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset(IconAssets.ic_hand)),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: CommonUtilites.commonEmailInputTextFormField(
                    _emailcontroller,
                    Icons.email,
                    StringManager.email,
                    StringManager.email,
                    ((p0) => Validation.getEmailCondition(p0))),
              ),
              const SizedBox(height: 16),
              Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: CommonUtilites.commonPassInputTextFormField(
                      _pass,
                      Icons.lock,
                      StringManager.password,
                      StringManager.password,
                      isShowPass, () {
                    setState(() {
                      if (isShowPass) {
                        isShowPass = false;
                      } else {
                        isShowPass = true;
                      }
                    });
                  }, (p0) => Validation.getPassCondition(p0))),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ResetPassScreen.id);
                        },
                        child: Text(
                          StringManager.forgotPassword,
                          style: TextStyle(color: ColorManager.secondary),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              CommonButtonTheme.getCircularButton(
                ColorManager.primary,
                context,
                StringManager.loginText,
                () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            CommonUtilites.loadingIndicator());

                    final user = await _authService.loginUser(
                        email: _emailcontroller.text.trim(),
                        password: _pass.text.trim(),
                        context: context);
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, Dashboard.id);
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              const SizedBox(height: 8),
              const Text(
                StringManager.or,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final userCredential =
                      await AuthService().signInWithGoogle() as UserCredential;

                  if (UserCredential != null) {
                    Navigator.pushReplacementNamed(context, Dashboard.id);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(StringManager.wrongPassword)));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorManager.secondary,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: ColorManager.white,
                            backgroundImage: const AssetImage(
                              IconAssets.ic_google,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Center(
                            child: isLoading1
                                ? Container(
                                    child: SpinKitCircle(
                                    color: ColorManager.white,
                                    size: 28,
                                  ))
                                : (Text(
                                    StringManager.googleSignin,
                                    style: TextStyle(
                                        color: ColorManager.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringManager.noAccount,
                      style: TextStyle(
                          color: ColorManager.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, SignupPage.id, (route) => false);
                      },
                      child: Text(
                        StringManager.signup,
                        style: TextStyle(
                            color: ColorManager.secondary,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
