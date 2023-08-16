import 'package:flutter/material.dart';

import 'package:loginflutter/passbooksettings.dart';
import 'package:loginflutter/addexpense.dart';
import 'package:loginflutter/alert.dart';
// import 'package:loginflutter/login.dart';
import 'package:loginflutter/passbook.dart';
import 'package:loginflutter/preference.dart';
import 'package:loginflutter/nextpage.dart';
import 'package:loginflutter/loginregister.dart';
import 'package:loginflutter/home.dart';
import 'package:loginflutter/register.dart';
import 'package:loginflutter/security.dart';
import 'package:loginflutter/splash.dart';
import 'package:loginflutter/sync.dart';
import 'package:loginflutter/transaction.dart';
import 'package:loginflutter/settings.dart';

// import 'onboardingstatusadapter.dart';



void main()  {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(UserAdapter());
  // await Hive.openBox<User>('users'); // Open the box


  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash',
    routes: {
      // 'login': (context)=> MyLogin(),
      'register':(context) => MyRegister(),
      'nextpage': (context) => nextpage(),
      'loginregister': (context) => LoginRegister(),
      'home': (context) => Home(transactions: transactions,),
      'transaction':(context) => TransactionPage(),
      'settings':(context) => SettingsPage(), 
      'expense': (context)=> AddExpense(),
      'psettings':(context) => psettings(),
      'preference':(context) => PreferencePage(),
      'alert':(context) => AlertPage(),
      'security':(context) => SecurityPage(),
      'sync':(context) => sync(),
      'passbook':(context) => PassbookPage(),
      'splash':(context) => splash(),
     
    },
  ));
}
