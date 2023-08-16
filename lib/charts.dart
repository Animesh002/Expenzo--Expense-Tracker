import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class charts extends StatefulWidget {
  const charts({Key? key}) : super(key: key);

  @override
  State<charts> createState() => _chartsState();
}

class _chartsState extends State<charts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:DecorationImage(
          image:AssetImage('lib/assets/potential.png'),fit: BoxFit.fill)),
      child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text('Charts', style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0.0,

      )
      )
      );
  }
}