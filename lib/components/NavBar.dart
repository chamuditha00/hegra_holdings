import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hegra_holdings/pages/last_submit.dart';
import 'package:hegra_holdings/pages/login_page.dart';
import 'package:hegra_holdings/pages/mid_day.dart';
import 'package:hegra_holdings/pages/start_page.dart';
import 'package:hegra_holdings/pages/summary.dart';
import 'package:intl/intl.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk:mm').format(DateTime.now());

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
            if (index == 1) {
              // Check if the current time is less than 12:00 PM
              if (formattedDate.compareTo('12:00') < 0) {
                // Show an AlertDialog if the time is less than 12:00 PM
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Submission Not Allowed'),
                      content: Text(
                          'You can only submit mid-day summary after 12:00 PM.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Close the dialog and navigate to index 0
                            Navigator.pop(context);
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Allow setting the index to 1
                setState(() {
                  _currentIndex = index;
                });
              }
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: buildIconWithBox(Icons.start, 0),
              label: 'Start',
              backgroundColor: Color.fromARGB(255, 214, 214, 214),
            ),
            BottomNavigationBarItem(
              icon: buildIconWithBox(Icons.note, 1),
              label: 'Mid Day',
              backgroundColor: Color.fromARGB(255, 214, 214, 214),
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
    // Show a confirmation dialog before signing out
    bool? shouldSignOut = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            // No button, close the dialog without signing out
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            // Yes button, close the dialog and return true to proceed with sign out
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    // If the user confirmed they want to sign out
    if (shouldSignOut == true) {
      try {
        // Sign out the user
        await FirebaseAuth.instance.signOut();
        // Navigate to the LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        print('Error during sign out: $e');
        // Handle sign-out error if necessary
      }
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
