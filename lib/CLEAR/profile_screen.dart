// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //AuthService _user = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Row(
            
            children: [
              Text("1"),
              Text("1"),
              Text("1"),
              Text("1"),
              ]
          ),
          // UserAccountsDrawerHeader(
          //   accountName: Text(_user.userData.name as String), accountEmail: Text(_user.userData.name as String)
            
          // )
              
        ],
    )
      ),
      );
  }
}