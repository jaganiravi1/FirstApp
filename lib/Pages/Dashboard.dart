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
      child: Text('Favourites'),
    ),
    Center(
      child: Text('Playlist'),
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
        onTap: (index) {
          setState(() {
            currentIndx = index;
          });
        },

        //type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favourits'),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play), label: 'Playlist'),
        ],
      ),
    );
  }
}
