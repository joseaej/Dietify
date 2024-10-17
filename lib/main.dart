// ignore_for_file: prefer_const_constructors

import 'package:dietify/AuthPages/sing_up_screen.dart';
import 'package:dietify/AuthPages/stiles_login.dart';
import 'package:dietify/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme, 
      home: SingUpScreen(),
    );
  }
}