import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hegra_holdings/pages/last_submit.dart';
import 'package:hegra_holdings/pages/login_page.dart';
import 'package:hegra_holdings/pages/mid_day.dart';
import 'package:hegra_holdings/pages/start_page.dart';
import 'package:hegra_holdings/pages/summary.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    StartPage(),
    MidDaySummary(),
    LastSubmit(),
    ConnectionDataPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black26,
          backgroundColor: Color.fromARGB(
              255, 202, 202, 202), // Set the background color here
          elevation: 0, // Set elevation to 0
          onTap: (index) {
            if (index == 4) {
              // Logout action
              _signOut();
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: buildIconWithBox(Icons.start, 0),
              label: 'Start',
              backgroundColor: Color.fromARGB(255, 112, 112, 112),
            ),
            BottomNavigationBarItem(
              icon: buildIconWithBox(Icons.note, 1),
              label: 'Mid Day',
              backgroundColor: Color.fromARGB(255, 179, 179, 179),
            ),
            BottomNavigationBarItem(
              icon: buildIconWithBox(Icons.last_page, 2),
              label: 'Last Submit',
              backgroundColor: Color.fromARGB(255, 214, 214, 214),
            ),
            BottomNavigationBarItem(
              icon: buildIconWithBox(Icons.data_array, 3),
              label: 'Summary',
              backgroundColor: Color.fromARGB(255, 214, 214, 214),
            ),
            BottomNavigationBarItem(
              icon: buildIconWithBox(Icons.logout, 4),
              label: 'Logout',
              backgroundColor: Color.fromARGB(255, 214, 214, 214),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error during sign out: $e');
      // Handle sign-out error if necessary
    }
  }

  Widget buildIconWithBox(IconData icon, int index) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? Color.fromARGB(255, 251, 249, 249)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 28,
          color: _currentIndex == index
              ? const Color.fromARGB(255, 67, 163, 71)
              : const Color.fromARGB(255, 10, 0, 0),
        ),
      ),
    );
  }
}
