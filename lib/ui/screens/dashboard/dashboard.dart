import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:application/ui/dialogs/dialog_box.dart';
import 'package:application/ui/screens/dashboard/wishlist_page/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'home_page/home_page.dart';

class Dashboard extends StatefulWidget {
  static String id = 'dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndx = 0;

  String? email = StringManager.userNotFound;
  String? userName = StringManager.userNotFound;
  @override
  List<Widget> screens = [
    const DrawerPage(),
    // const Center(
    //   child: Text('Home'),
    // ),
    const Center(
      child: Text('Vendors'),
    ),
    const MyLists(),
    const Center(
      child: Text('Categories'),
    ),
    const Center(
      child: Text('More'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialogBox.exitAppAleartDialog(context);
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(value);
        }
      },
      child: Scaffold(
        body: screens[currentIndx],
        // appBar: AppBar(
        //   title: Text(StringManager.splashscreenText),
        //   centerTitle: true,
        //   backgroundColor: ColorManager.primary,
        // ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndx,
          fixedColor: ColorManager.primary,
          unselectedItemColor: ColorManager.lightGrey,
          onTap: (index) {
            setState(() {
              currentIndx = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: StringManager.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: StringManager.vendors),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: StringManager.lists),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: StringManager.categories),
            BottomNavigationBarItem(
                icon: Icon(Icons.more), label: StringManager.more),
          ],
        ),
      ),
    );
  }
}
