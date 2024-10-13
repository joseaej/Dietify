// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: _body,
    ));
  }
}

Widget get _body => Container(
  color: Colors.white,
  child: Row(
    children: [
      Text("Hola"),
      Text("Hola"),
    ],
  )
);