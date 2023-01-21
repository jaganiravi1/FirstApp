import 'dart:convert';

import 'package:application/Authntication/auth.dart';
import 'package:application/bloc/network_cubit.dart';
import 'package:application/controller/randomuser_provider.dart';
import 'package:application/model/responses/random_user/random_user.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:application/ui/dialogs/dialog_box.dart';
import 'package:application/ui/screens/dashboard/home_page/language_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../utilites/network_utilities.dart';

class DrawerPage extends StatefulWidget {
  static String id = 'drawer';
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  late RandomUserProvider randomUserProvider;
  String? email, userName;
  bool isDataReceived = false;
  final AuthService _authService = AuthService();
  User? _user;
  //var randomUserModel = CommonUser.fromJson(jsonDecode(response.body));

  @override
  void initState() {
    _user = _authService.getUser();
    setState(() {
      email = _user?.email;
      userName = _user?.displayName;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    randomUserProvider = Provider.of<RandomUserProvider>(context);
    randomUserProvider.networkCubit ??= BlocProvider.of<NetworkCubit>(context);

    getRandomUser();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
      ),
      drawer: Drawer(
        backgroundColor: ColorManager.primary,
        child: SafeArea(
          child: Container(
            color: ColorManager.white,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: ColorManager.primary),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: ColorManager.white,
                    child: Icon(
                      Icons.person,
                      color: ColorManager.primary,
                      size: 38,
                    ),
                  ),
                  accountEmail: Text(email ?? StringManager.userNotFound),
                  accountName: Text(
                    userName ?? StringManager.userNotFound,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                commonListTile(Icons.payment, StringManager.payment,
                    () => Navigator.pop(context)),
                commonDevider(),
                commonListTile(Icons.location_city, StringManager.address,
                    () => Navigator.pop(context)),
                commonDevider(),
                commonListTile(Icons.lock, StringManager.password,
                    () => Navigator.pop(context)),
                commonDevider(),
                commonListTile(Icons.more, StringManager.other,
                    () => Navigator.pop(context)),
                commonDevider(),
                commonListTile(Icons.change_circle, StringManager.changeLang,
                    () => Navigator.pushNamed(context, ChangeLanguage.id)),
                commonDevider(),
                commonListTile(
                    Icons.logout,
                    StringManager.signOut,
                    () => showDialog(
                        context: context,
                        builder: ((context) =>
                            AlertDialogBox.signoutAleartDialog(context)))),
                commonDevider(),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40,),
             "${randomUserModel.results.first.picture.large}" != null ?
                Image.network(randomUserModel.results.first.picture.large):Container(),

             
              // Image.network(randomUserModel != null
              //     ? randomUserModel.results.first.picture.large
              //     : ""),
                  Text(randomUserModel != null
                  ? randomUserModel.results.first.gender
                  : ""),
              Text(randomUserModel != null
                  ? randomUserModel.results.first.email
                  : ""),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget commonListTile(IconData iconData, String txt, Function() tapFun) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Icon(iconData),
      ),
      title: Text(
        txt,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: tapFun,
    );
  }

  commonDevider() {
    return Divider(
      thickness: 0.8,
      color: Colors.black12,
    );
  }

  var randomUserModel;

  getRandomUser() async {
    if (isDataReceived) {
      return;
    }
    isDataReceived = true;
    var response = await randomUserProvider.getRandomUser();
    var parseRes = NetworkUtils().handleResponse(response, context);
    //print("DOB : ${randomUserModel.results.first.dob}");

    if (parseRes != null) {
      // print(parseRes);
      randomUserModel = CommonUser.fromJson(jsonDecode(response.body));
      setState(() {});
    }
  }
}
