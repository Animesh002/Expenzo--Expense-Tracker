import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  void _showComingSoonAlert(String featureName) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.black54,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Coming Soon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'The $featureName feature is currently under development.',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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
          leading: BackButton(),
          title: Row(
            children: [
              Text(
                'Alerts and Notifications',
                style: TextStyle(
                  color: Colors.white,
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
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          children: [
            ListTile(
              title: Text(
                'Email Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                'Manage content received via email from mobile',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              onTap: () {
                _showComingSoonAlert('Email Settings');
              },
            ),
            ListTile(
              title: Text(
                'Notification Reading (Beta)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _showComingSoonAlert('Notification Reading (Beta)');
              },
            ),
            ListTile(
              title: Text(
                'Default Notification Reading',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                'The default behavior set for notification reading (debit or credit)',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              onTap: () {
                _showComingSoonAlert('Default Notification Reading');
              },
            ),
            ListTile(
              title: Text(
                'Expense Alert',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(
                'Payments and Alerts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _showComingSoonAlert('Payments and Alerts');
              },
            ),
            ListTile(
              title: Text(
                'Daily Reminder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _showComingSoonAlert('Daily Reminder');
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlertPage(),
    );
  }
}