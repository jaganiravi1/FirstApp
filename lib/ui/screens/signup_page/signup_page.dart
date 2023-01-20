import 'package:application/Authntication/auth.dart';
import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:application/ui/screens/dashboard/dashboard.dart';
import 'package:application/ui/screens/login_page/login_page.dart';
import 'package:application/ui/utilites/button_theme.dart';
import 'package:application/ui/validator/validation.dart';
import 'package:flutter/material.dart';
import '../../utilites/common_utilities.dart';

class SignupPage extends StatefulWidget {
  static String id = 'signup';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isShowPass = false;
  bool isShowPass1 = false;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    StringManager.signup,
                    style: TextStyle(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              const Text(StringManager.createNewAcc,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: CommonUtilites.commonEmailInputTextFormField(
                    _usernamecontroller,
                    Icons.person,
                    StringManager.Username,
                    StringManager.Username, (value) {
                  if (value!.isEmpty) {
                    return StringManager.required;
                  }
                  return null;
                }),
              ),
              sizedBoxH16(),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: CommonUtilites.commonEmailInputTextFormField(
                    _emailcontroller,
                    Icons.email,
                    StringManager.email,
                    StringManager.email,
                    ((p0) => Validation.getEmailCondition(p0))),
              ),
              sizedBoxH16(),
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
              sizedBoxH16(),
              Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: CommonUtilites.commonPassInputTextFormField(
                      _confirmpass,
                      Icons.lock,
                      StringManager.confirmPass,
                      StringManager.password,
                      isShowPass1, () {
                    setState(() {
                      if (isShowPass1) {
                        isShowPass1 = false;
                      } else {
                        isShowPass1 = true;
                      }
                    });
                  },
                      (p0) =>
                          Validation.getConfirmPassCondition(p0, _pass.text))),
              sizedBoxH16(),
              CommonButtonTheme.getCircularButton(
                ColorManager.primary,
                context,
                StringManager.signup,
                () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            CommonUtilites.loadingIndicator());
                    final user = await _authService.createNewAccount(
                        email: _emailcontroller.text,
                        userName: _usernamecontroller.text,
                        password: _pass.text,
                        context: context);
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, Dashboard.id);
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              sizedBoxH16(),
              const Text(
                StringManager.or,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              sizedBoxH16(),
              InkWell(
                onTap: () async {
                  final UserCredential = AuthService().signInWithGoogle();
                  if (UserCredential != null) {
                    Navigator.pushReplacementNamed(context, Dashboard.id);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(StringManager.wrong)));
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
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: ColorManager.white,
                            backgroundImage: const AssetImage(
                              IconAssets.ic_google,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            StringManager.googleSignin,
                            style: TextStyle(
                                color: ColorManager.white,
                                fontWeight: FontWeight.bold),
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
                  const Text(StringManager.alreadyAcc,
                      style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                    },
                    child: Text(
                      StringManager.loginText,
                      style: TextStyle(
                          color: ColorManager.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sizedBoxH16() {
    return const SizedBox(height: 16);
  }
}
