import 'package:application/Authntication/auth.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:application/ui/dialogs/dialog_box.dart';
import 'package:application/ui/screens/login_page/login_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String? email, userName;
  
   final AuthService _authService = AuthService();
  User? _user;
  
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
    return Scaffold(
      appBar: AppBar(
        
       backgroundColor: ColorManager.primary, 
      ),
      drawer: Drawer(
        
        
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: ColorManager.primary),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
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
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.payment_outlined,
                    color: ColorManager.secondary),
              ),
              title: Text(
                StringManager.payment,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 0.8,
              color: Colors.black12,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.location_city,
                    color: ColorManager.secondary),
              ),
              title: Text(
                StringManager.address,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 0.8,
              color: Colors.black12,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.privacy_tip,
                    color: ColorManager.secondary),
              ),
              title: Text(
                StringManager.password,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 0.8,
              color: Colors.black12,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.more,
                    color: ColorManager.secondary),
              ),
              title: Text(
                StringManager.other,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 0.8,
              color: Colors.black12,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.logout,
                    color: ColorManager.secondary),
              ),
              title: Text(
                StringManager.signOut,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: ((context) => AlertDialogBox.signoutAleartDialog(context)
                        ),
                        );
              },
            ),
          ],
        ),
      ),
    );
  }
}