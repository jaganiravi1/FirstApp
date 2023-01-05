import 'package:application/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndx = 0;

  List<Widget> screens = [
    Center(
      child: Text('HomePage'),
    ),
    Center(
      child: Text('Vendors'),
    ),
    Center(
      child: Text('Lists'),
    ),
    Center(
      child: Text('Categories'),
    ),
    Center(
      child: Text('More'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndx],
      appBar: AppBar(
        title: Text('Music'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndx,
        fixedColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black45,
        onTap: (index) {
          setState(() {
            currentIndx = index;
          });
        },

        //type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Vendors'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lists'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: 'More'),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                  size: 38,
                ),
              ),
              accountEmail: Text('jaganiravi@gmail.com'),
              accountName: Text(
                'Ravi Jagani',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.payment_outlined,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              title: Text(
                'Payment Method',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 0.8,
              color: Colors.black12,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.location_city,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              title: Text(
                'Addresses',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 0.8,
              color: Colors.black12,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.privacy_tip,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              title: Text(
                'Password',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 0.8,
              color: Colors.black12,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.more,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              title: Text(
                'Other',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 0.8,
              color: Colors.black12,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.logout,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              title: Text(
                'Sign out',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          title: Text(
                            'Are you sure want to signout?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.red)),
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();

                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (route) => false);
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 8),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStatePropertyAll(0),
                                      side: MaterialStatePropertyAll(BorderSide(
                                        color: Colors.redAccent,
                                      )),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.transparent)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
