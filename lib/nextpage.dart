import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginflutter/home.dart' ;
import 'package:loginflutter/passbook.dart';
import 'package:loginflutter/settings.dart';
import 'package:loginflutter/transaction.dart';

class nextpage extends StatefulWidget {
  const nextpage({Key? key}) : super(key: key);

  @override
  State<nextpage> createState() => _nextpageState();
}

class _nextpageState extends State<nextpage> {
  int _currentIndex = 0;

  List<Widget> pages = [
    Home(transactions: transactions,),
    PassbookPage(),
    SettingsPage(),
  ];

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Pop with 'true' value to confirm logout
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Pop with 'false' value to cancel logout
            },
            child: Text('No'),
          ),
        ],
      ),
    ).then((value) => value ?? false); // Return 'false' if the dialog is dismissed without selecting an option
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/potential.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          body: pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Passbook',
                icon: Icon(Icons.wallet_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(Icons.settings),
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: Color(0xff6953f7),
            unselectedItemColor: Colors.black54,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
