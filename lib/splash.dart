import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
@override
  void initState() {
    super.initState();
    navigateToLoginRegister();
  }

  void navigateToLoginRegister() async {
    await Future.delayed(Duration(seconds: 2)); // Adjust the delay time as desired
    Navigator.pushReplacementNamed(context, 'loginregister');
  }




@override
Widget build(BuildContext context) {
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'lib/assets/ET.png',
        width: 150,
        height: 150,
      ),
    ),
  );
}
}