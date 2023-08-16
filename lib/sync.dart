import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class sync extends StatefulWidget {
  const sync({Key? key}) : super(key: key);

  @override
  State<sync> createState() => _syncState();
}

class _syncState extends State<sync> {
  @override
  Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
        image:DecorationImage(
          image:AssetImage('lib/assets/potential.png'),fit: BoxFit.fill)),
          child: Scaffold(
         backgroundColor: Colors.transparent,
            appBar:  AppBar(
              leading: BackButton(),
              title: Row(
          children:[ Text('Synchronization',style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)), 
        ],),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,),
          )
    );
  }
}