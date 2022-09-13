
import 'package:flutter/material.dart';
import './login.dart';
import './signup.dart';
import './handgrip.dart';
import './neck.dart';
import './leg.dart';
import './arm.dart';
import './foot.dart';
import './finger.dart';
import './back.dart';
import './deviceselection.dart';
import './searchdevice.dart';
import './devicesucess.dart';
import './onboard.dart';
import './results.dart';
import 'deviceunsucess.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Assessment',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyLogin(),
        '/signup': (context) => const MyRegister(),
        '/deviceselection': (context) => const deviceselect(),
        '/searchdevice': (context) => const searchdevice(),
        '/deviceunsucess': (context) => const deviceunsucess(),
      },
    ),
  );
}
