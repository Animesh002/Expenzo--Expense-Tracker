import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loginflutter/login.dart'; // Import the login screen or the screen you want to navigate to after logout

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool showComingSoon = false;

  List<SettingItem> settings = [
    SettingItem(
      name: 'Preference',
      icon: Icons.man,
      routeName: 'preference',
    ),
    SettingItem(
      name: 'Alerts and notification',
      icon: Icons.notifications,
      routeName: 'alert',
    ),
    SettingItem(
      name: 'Security',
      icon: Icons.security,
      routeName: 'security',
    ),
    SettingItem(
      name: 'Synchronization',
      icon: Icons.sync,
      routeName: 'sync',
    ),
    SettingItem(
      name: 'Rate App',
      icon: Icons.star,
      routeName: '/',
    ),
    SettingItem(
      name: 'Terms of use',
      icon: Icons.verified,
      routeName: '/',
    ),
    SettingItem(
      name: 'Help Center',
      icon: Icons.question_mark,
      routeName: '/',
    ),
    SettingItem(
      name: 'About',
      icon: Icons.book,
      routeName: '/',
    ),
    SettingItem(
      name: 'Logout',
      icon: Icons.logout,
      routeName: 'register',
    ),
  ];

 void _logout() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              // Perform any logout-related operations here
              // For example, clear user session, navigate to login screen, etc.

              // Clear user session or perform any necessary logout operations

              // Navigate to the desired login/register page
              Navigator.pushNamed(
                context, 'register');
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/potential.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: settings.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          settings[index].icon,
                          color: Colors.white,
                        ),
                        title: Text(
                          settings[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          if (index == settings.length - 1) {
                            _logout();
                          } else if (index >= 3) {
                            setState(() {
                              showComingSoon = true;
                            });
                            Timer(Duration(milliseconds: 200), () {
                              setState(() {
                                showComingSoon = false;
                              });
                            });
                          } else {
                            Navigator.pushNamed(
                              context,
                              settings[index].routeName,
                            );
                          }
                        },
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        indent: 16,
                        endIndent: 16,
                      )
                    ],
                  );
                },
              ),
            ),
            if (showComingSoon)
              Container(
                color: Colors.black.withOpacity(0.6),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Coming Soon',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SettingItem {
  final String name;
  final IconData icon;
  final String routeName;

  SettingItem({
    required this.name,
    required this.icon,
    required this.routeName,
  });
}