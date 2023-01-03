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
        backgroundColor: Colors.pink,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndx,
        fixedColor: Colors.pinkAccent,
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
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              accountEmail: Text('jaganiravi@gmail.com'),
              accountName: Text(
                'Ravi Jagani',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.payment_outlined),
              ),
              title: Text(
                'Payment Method',
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 0.8,
              color: Color.fromARGB(255, 251, 189, 210),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.location_city),
              ),
              title: Text(
                'Addresses',
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 0.8,
              color: Color.fromARGB(255, 251, 189, 210),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.privacy_tip),
              ),
              title: Text(
                'Password',
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 0.8,
              color: Color.fromARGB(255, 251, 189, 210),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(Icons.more),
              ),
              title: Text(
                'Other',
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
