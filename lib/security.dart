import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _lockWithFingerprint = false;

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

  void _toggleLockWithFingerprint(bool value) {
    setState(() {
      _lockWithFingerprint = value;
    });

    if (value) {
      _authenticateFingerprint();
    }
  }

  Future<void> _authenticateFingerprint() async {
    try {
      const platform = const MethodChannel('your_channel_name');
      final bool isAuthenticated = await platform.invokeMethod('authenticateFingerprint');

      if (isAuthenticated) {
        // Add your security feature here
        print('Fingerprint authenticated. Lock with fingerprint enabled.');
      } else {
        setState(() {
          _lockWithFingerprint = false;
        });
      }
    } on PlatformException catch (e) {
      print('Failed to authenticate fingerprint: ${e.message}');
      setState(() {
        _lockWithFingerprint = false;
      });
    }
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
                'Security',
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
                'Passwords',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _showComingSoonAlert('Passwords');
              },
            ),
            ListTile(
              title: Text(
                'Lock with Fingerprint',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              trailing: Switch(
                value: _lockWithFingerprint,
                onChanged: _toggleLockWithFingerprint,
                activeColor: Colors.black,
              ),
            ),
            ListTile(
              title: Text(
                'Connected Devices',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                _showComingSoonAlert('Connected Devices');
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
      title: 'Security Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SecurityPage(),
    );
  }
}